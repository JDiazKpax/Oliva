
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oliva/User/bloc/authBloc.dart';
import 'package:oliva/User/bloc/dataBloc.dart';
import 'package:oliva/User/model/data_event.dart';
import 'package:oliva/User/model/data_state.dart';
import 'package:oliva/User/model/user.dart';
import 'package:oliva/User/ui/screens/home_screen.dart';
import 'package:oliva/User/ui/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:oliva/widgets/loading_inidicator.dart';

class HomeSelector extends StatefulWidget {
  
  @override
  State createState() {
        return _HomeSelector();
  }
}

class _HomeSelector extends State<HomeSelector> {
 
  User user;
  DataBloc dataBloc;
  // ignore: close_sinks
  AuthenticationBloc authBloc;

  @override
  void initState(){    
    dataBloc = DataBloc();
    dataBloc.add(BringData());
    super.initState();
  }

  @override
  void dispose() {
    dataBloc.close();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    authBloc = BlocProvider.of<AuthenticationBloc>(context);
  
    return BlocProvider<DataBloc>(
      create: (context) => dataBloc,
      child: BlocBuilder<DataBloc, DataState>(
          bloc: dataBloc,
          builder: (BuildContext context, DataState state) {
            if (state is DataUnrequested) {
              return SplashScreen();
            }
            if (state is DataBrought) {
               return HomeScreen(state);              
            }
            if (state is DataUnbrought) {
              return LoadingIndicator();
            }
            else{
              return CircularProgressIndicator();
            }
          },
        )
      );
     
  }
}




