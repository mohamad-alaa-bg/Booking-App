import 'package:booking_services/core/base_use_cases.dart';
import 'package:booking_services/core/errors/failures.dart';
import 'package:booking_services/features/authentication/domain/repository/authentication_repository.dart';
import 'package:dartz/dartz.dart';

class LogoutUseCase extends UseCaseNoFutureNoParams {
  final AuthenticationRepository authenticationRepository;

  LogoutUseCase({required this.authenticationRepository});

  @override
  Either<Failure, dynamic> call() {
    return authenticationRepository.logout();
  }
}
