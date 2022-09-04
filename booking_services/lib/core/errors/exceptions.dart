abstract class BookingsException implements Exception {}

class UnauthorizedException implements BookingsException {
  final String message;

  UnauthorizedException({required this.message});
}

class AuthenticationException implements BookingsException {
  final String message;

  AuthenticationException({required this.message});
}

class UnhandledException implements BookingsException {
  final String message;

  UnhandledException({required this.message});
}
