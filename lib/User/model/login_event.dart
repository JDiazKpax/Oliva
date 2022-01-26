//de UI a Bloc
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class LoginEvent extends Equatable{
  const LoginEvent();
}

class LoginButtonPressedGoogle extends LoginEvent {
    @override
    List<Object> get props => [];
    
    String toString() => 'Iniciando Sesión con Google';
}

class LoginButtonPressedFacebook extends LoginEvent {
    final String result;

    @override
    List<Object> get props => [];

    const LoginButtonPressedFacebook({
    @required this.result,
    });
    String toString() => 'Iniciando Sesión con Facebook';
}

class LoginButtonPressedTwitter extends LoginEvent {
    final String result;

     @override
  List<Object> get props => [];

    const LoginButtonPressedTwitter({
    @required this.result,
    });
    String toString() => 'Iniciando Sesión con Twitter';
}