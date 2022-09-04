part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationState {}

class AuthenticationInitial extends AuthenticationState {}

class LoginSuccessfullyState extends AuthenticationState {
  final UserEntity user;

  LoginSuccessfullyState({required this.user});
}

class SignUpSuccessfullyState extends AuthenticationState {
  final UserEntity user;

  SignUpSuccessfullyState({required this.user});
}

class LoadingState extends AuthenticationState {}

class LogoutSuccessfullyState extends AuthenticationState {}

class AuthErrorState extends AuthenticationState {
  final String message;

  AuthErrorState({required this.message});
}
