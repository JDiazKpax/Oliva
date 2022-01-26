//Es lo que se enviará de UI a Bloc
import 'package:equatable/equatable.dart';

abstract class AuthenticationEvent extends Equatable {
  AuthenticationEvent([List props = const []]) : super();
  get props => [];
}

// will be dispatched when the Flutter application first loads. 
//It will notify bloc that it needs to determine whether or not 
//there is an existing user.
class AppStarted extends AuthenticationEvent {
  @override
  String toString() => 'AppStarted';
}

//will be dispatched on a successful login. 
//It will notify the bloc that the user has successfully logged in.
class LoggedIn extends AuthenticationEvent {
  @override
  String toString() => 'LoggedIn';
}

//will be dispatched on a successful logout.
//It will notify the bloc that the user has successfully logged out.
class LoggedOut extends AuthenticationEvent {
  @override
  String toString() => 'LoggedOut';
}