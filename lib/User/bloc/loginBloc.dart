//Bloc para el procedimiento de Login

import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:oliva/User/bloc/authBloc.dart';
import 'package:oliva/User/model/auth_events.dart';
import 'package:oliva/User/model/login_event.dart';
import 'package:oliva/User/model/login_state.dart';
import 'package:oliva/User/model/user.dart';
import 'package:oliva/User/repository/cloud_firestore_api.dart';
import 'package:oliva/User/repository/firebase_auth_api.dart';


class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthenticationBloc authBloc;
  final _authRepository = FirebaseAuthAPI();
  final _cloudFirestoreAPI = CloudFirestoreAPI();

  LoginBloc({
    @required this.authBloc,
  })  : assert(authBloc != null);

  //first state:
  @override
  LoginState get initialState => LoginInitial();

  //@override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginButtonPressedGoogle) {
      yield LoginLoading();

      try {
        //Hacer Login con Firebase y Registrar en BD Firestore
        FirebaseUser user = await _authRepository.signInGoogle();
        _cloudFirestoreAPI.insertUserData(
          User(
            uid: user.uid,
            name: user.displayName,
            email: user.providerData[1].email,
            photoURL: user.photoUrl,
            onboardSeen: "no",
          ));
       // await new Future.delayed(const Duration(seconds: 3));
        authBloc.add(LoggedIn());
        
        
        yield LoginInitial();
      
      } catch (error) {
        yield LoginFailure(error: error.toString());
      }
    }

    if (event is LoginButtonPressedFacebook) {
      yield LoginLoading();

      try {
        await _authRepository.signInFacebook(event.result);
        authBloc.add(LoggedIn());
        yield LoginInitial();
      } catch (error) {
        yield LoginFailure(error: error.toString());
      }
    }
  }
}