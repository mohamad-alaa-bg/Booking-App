abstract class Failure {
  final String message;

  Failure({required this.message});

  /// returning current class name as error type
  String get errorType => runtimeType.toString();
}

class UnauthorizedFailure extends Failure {
  UnauthorizedFailure(String message) : super(message: message);
}

class UnhandledFailure extends Failure {
  UnhandledFailure(String message) : super(message: message);
}

class AuthenticationFailure extends Failure {
  AuthenticationFailure(String message) : super(message: message);
}
