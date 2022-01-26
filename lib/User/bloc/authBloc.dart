//Bloc para los estados de autenticación

import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:oliva/User/model/auth_events.dart';
import 'package:oliva/User/model/auth_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {

  final GoogleSignIn googleSignIn = GoogleSignIn();
  //since the first thing our app will need to do is determine whether or not a user is logged in.
  @override
  AuthenticationState get initialState => AuthenticationUninitialized();
  
 //mapEventToState is where the bloc converts the incoming events 
 //into states the are consumed by the presentational layer.
  @override
  Stream<AuthenticationState> mapEventToState(AuthenticationEvent event) async* {
    if (event is AppStarted) {

     //obtener el ID del usuario logueado:             
     FirebaseUser currentUser = await FirebaseAuth.instance.currentUser();
  //   await new Future.delayed(const Duration(seconds: 3));

     if (currentUser != null)  {
         yield AuthenticationAuthenticated();
     } else {
         yield AuthenticationUnauthenticated();
     }
    }

    //si el usuario se logueó exitosamente
    if (event is LoggedIn) {
      yield AuthenticationLoading();
    
      yield AuthenticationAuthenticated();
    }

   //si el usuario se deslogueó exitosamente
    if (event is LoggedOut) {
      yield AuthenticationLoading();
      await FirebaseAuth.instance.signOut().then((onValue) => print("Ended Session"));
      googleSignIn.signOut();
      yield AuthenticationUnauthenticated();
    }
  } 
}