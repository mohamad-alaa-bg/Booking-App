import 'package:booking_services/core/errors/exceptions.dart';

import 'failures.dart';

mixin ErrorHandler {
  Failure mapCommonExceptionToFailure(Exception exception) {
    if (exception is UnauthorizedException) {
      return UnauthorizedFailure(exception.message);
    } else if (exception is UnhandledException) {
      return UnhandledFailure(exception.message);
    } else if (exception is AuthenticationException) {
      if (exception.message == 'user-not-found') {
        return AuthenticationFailure('No user found for that email.');
      } else if (exception.message == 'wrong-password') {
        return AuthenticationFailure('Wrong password provided for that user.');
      } else if (exception.message == 'weak-password') {
        return AuthenticationFailure('The password provided is too weak.');
      } else if (exception.message == 'email-already-in-use') {
        return AuthenticationFailure(
            'The account already exists for that email.');
      }
      return AuthenticationFailure(exception.message);
    }
    return UnhandledFailure('Unhandled Error');
  }
}
