//Es lo que se enviará de Bloc a UI
import 'package:equatable/equatable.dart';

abstract class AuthenticationState extends Equatable {
  @override
  List<Object> get props => [];
}

//waiting to see if the user is authenticated or not on app start. -> SplashScreen
class AuthenticationUninitialized extends AuthenticationState {}

//successfully authenticated ->  Home
class AuthenticationAuthenticated extends AuthenticationState {}

//not authenticated -> SignIn
class AuthenticationUnauthenticated extends AuthenticationState {}

//waiting to persist/delete a token -> Progress Indicator
class AuthenticationLoading extends AuthenticationState {}