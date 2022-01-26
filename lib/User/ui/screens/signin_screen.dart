import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oliva/User/bloc/authBloc.dart';
import 'package:oliva/User/bloc/loginBloc.dart';
import 'package:oliva/User/model/login_event.dart';
import 'package:oliva/User/model/login_state.dart';
import 'package:oliva/widgets/button_click.dart';
//import 'package:oliva/widgets/customwebview.dart';
import 'package:oliva/widgets/gradient.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatefulWidget {
  
  @override
  State createState() {
        return _SignInScreen();
  }
}

class _SignInScreen extends State<SignInScreen> {
  
  final String loginText = "Inicia sesión con:";
  final String logoText = "Cocinemos diferente hoy";
  // ignore: close_sinks
  AuthenticationBloc _authBloc;
  LoginBloc _loginBloc;

  @override
  void initState(){
    _authBloc = BlocProvider.of<AuthenticationBloc>(context);
    _loginBloc = LoginBloc(
      authBloc: _authBloc,
    );
    super.initState();
  }
  //ONEPLUS:
  //Screen Largest: height: 592.0 - width: 320.0
  //Screen Larger: height: 643.2 - width: 345.6
  //Screen Large: height: 672.0 - width: 360.0
  //Screen Default: height: 774.85 - width: 411.43
  //Screen Small: height: 861.47 - width: 454.74

  //SAMSUNG J7:
  //Screen Zoom Grande: height: 569.0 - width: 320.0
  //Screen Zoom Default: height: 640.0 - width: 360.0
  //Screen Zoom Pequeño: height: 731.42 - width: 411.43
  //TextZoom Diminuto: textScaleFactor: 0.8
  //TextZoom Default: textScaleFactor: 1.1
  //TextZoom Enorme: textScaleFactor: 1.7
  
  @override 
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double systemSize = MediaQuery.of(context).textScaleFactor;
    int divisor;
    int divisor2 = 5; 
    double textFont = 18.0;
    double textFont2 = 21.0;
    if(height > 700){
      divisor = 6;
    }else{
      if(height < 600){
        divisor = 20;
        divisor2 = 20;
      }else{
        divisor = 15;
      }
    }

    if(systemSize > 1.4){
      divisor = 15;
      textFont = 13.0;
      textFont2 = 16.0;
    }



    return Scaffold(
        body:BlocBuilder<LoginBloc, LoginState>(
           bloc: _loginBloc,
            builder: (
              BuildContext context,
              LoginState state,
            ) 
            {
              if (state is LoginFailure) {
                _onWidgetDidBuild(() {
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${state.error}'),
                      backgroundColor: Colors.red,
                    ),
                  );
                });
              }

              return Stack( 
                alignment: Alignment.center,
                children: <Widget>[
                  GradientBack("",null),    //Si paso la altura como null, me lo toma como fullscreen
                  Container(
                    margin: EdgeInsets.only(
                     // top: 200.0,
                      top: height/divisor2,
                     // bottom: 40.0,              
                    ),
                    child: Column(
                      children: <Widget>[
                          Container(      //Logo
                            height: 280.0,
                            width: 330.0,
                            decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("assets/img/logo.png"), 
                              ),
                            ),      
                          ),
                          Container(  // Frase App
                            margin: EdgeInsets.only(
                              top: 30.0,
                            ),
                            child: Column(
                            children: <Widget>[  
                              Text(
                                logoText,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xFF663300),
                                  fontSize: textFont2,
                                  fontFamily: "Nunito",
                                ),                        
                              ),
                            ]
                            ),
                          ),
                          Container(  //Frase Login
                            margin: EdgeInsets.only(
                              top: height/divisor,
                              bottom:20.0
                            ),
                            child: Column(
                            children: <Widget>[
                              Text(
                                loginText,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xFF663300),
                                  fontSize: textFont,
                                  fontFamily: "Nunito",
                                ), 
                              ),
                            ],
                            ),
                          ),
                          Container(  // Sign In Icons
                            margin: EdgeInsets.only(
                              top: 0.0,
                            ),
                            child: Row(
                            children: <Widget>[ 
                              ButtonClick(
                                onPressed: () {
                                   // ignore: unnecessary_statements
                                   state is! LoginLoading ? _onLoginButtonPressedGoogle() : null;
                                }, 
                                buttonHeight: 50.0, 
                                buttonWidth: 50.0, 
                                imagePath: "assets/img/google.png",
                                buttonLeft: (width/2)-25.0,
                                buttonTop:0.0,
                                buttonBottom: 0.0,
                                buttonRight: 0.0,
                                ),
                               /* ButtonClick(
                                onPressed: () async {
                                      String clientId = "239133934041960";
                                      String redirectUrl = "https://www.facebook.com/connect/login_success.html";
                                      String result = await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => CustomWebView(selectedUrl:'https://www.facebook.com/dialog/oauth?client_id=$clientId&redirect_uri=$redirectUrl&response_type=token&scope=email,public_profile,',),
                                                maintainState: true
                                            ),
                                        ); 
                                      // ignore: unnecessary_statements
                                      state is! LoginLoading ? _onLoginButtonPressedFacebook(result) : null;
                                }, 
                                buttonHeight: 50.0, 
                                buttonWidth: 50.0, 
                                imagePath: "assets/img/facebook.png",
                                buttonLeft: 30.0,
                                buttonTop:0.0,
                                buttonBottom: 0.0,
                                buttonRight: 0.0,
                                ),     */                          
                              ] 
                            )
                          ),
                          //Container(
                          //  child:
                          //    state is LoginLoading ? CircularProgressIndicator() : null,
                         // )
                      ]
                    ),
                 )
                ]
                
              );
            }
        )
    );
  }

  void _onWidgetDidBuild(Function callback) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      callback();
    });
  }

  _onLoginButtonPressedGoogle() {
    _loginBloc.add(LoginButtonPressedGoogle());
  }

  /*_onLoginButtonPressedFacebook(String result) {
    _loginBloc.add(LoginButtonPressedFacebook(result: result));
  }*/

  @override
  void dispose() {
    _loginBloc.close();
    super.dispose();
  }

}
