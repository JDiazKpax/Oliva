import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oliva/User/bloc/authBloc.dart';
import 'package:oliva/User/model/auth_events.dart';
import 'package:oliva/User/model/auth_state.dart';
import 'package:oliva/User/ui/screens/onboard_animated.dart';
import 'package:oliva/User/ui/screens/signin_screen.dart';
import 'package:oliva/User/ui/screens/splash_screen.dart';
import 'package:oliva/User/ui/widgets/home_selector.dart';
import 'package:oliva/widgets/loading_inidicator.dart';
                                                                                    
void main() {
   SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Color(0xFFC6FAFF),
        statusBarIconBrightness: Brightness.dark
        ));
        
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MyHomePage();   
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);
  
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  AuthenticationBloc authBloc;
  
  @override
  void initState(){  
    this.initDynamicLinks();  
    authBloc = AuthenticationBloc();
    //authBloc.add(LoggedOut());
    authBloc.add(AppStarted());
    super.initState();
    
  }

  @override
  void dispose() {
    authBloc.close();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthenticationBloc>(
      create: (context) => authBloc,
      child: 
      MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          "/onBoard": (context) => OnboardAnimated(),
          
        },
        home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          bloc: authBloc,
          builder: (BuildContext context, AuthenticationState state) {
            if (state is AuthenticationUninitialized) {
              return SplashScreen();
            }
            if (state is AuthenticationAuthenticated) {
              return HomeSelector();
            }
            if (state is AuthenticationUnauthenticated) {
              return SignInScreen();
            }
            if (state is AuthenticationLoading) {
              return LoadingIndicator();
            }
            else{
              return CircularProgressIndicator();
            }
          },
        )
      )
    ); 
  }

  initDynamicLinks() async {
    await Future.delayed(Duration(seconds: 3)); 
    var data = await FirebaseDynamicLinks.instance.getInitialLink();
    var deepLink = data?.link;
    if (deepLink!=null) { final queryParams = deepLink.queryParameters;
    if (queryParams.length > 0) {
      //var userName = queryParams['userId'];
    }}

    FirebaseDynamicLinks.instance.onLink(onSuccess: (dynamicLink) 
      async {
      var deepLink = dynamicLink?.link;
      debugPrint('DynamicLinks onLink $deepLink');
    }, onError: (e) async {
      debugPrint('DynamicLinks onError $e');
    });
  }
}
