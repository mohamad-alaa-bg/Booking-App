part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationEvent {}

class LoginEvent extends AuthenticationEvent {
  final String email;
  final String password;

  LoginEvent({required this.email, required this.password});
}

class SignUpEvent extends AuthenticationEvent {
  final String email;
  final String password;
  final String username;
  final String phoneNum;

  SignUpEvent(
      {required this.email,
      required this.password,
      required this.username,
      required this.phoneNum});
}

class LogoutEvent extends AuthenticationEvent {}
