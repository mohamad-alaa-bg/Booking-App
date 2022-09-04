import 'package:booking_services/core/base_use_cases.dart';
import 'package:booking_services/core/errors/failures.dart';
import 'package:booking_services/features/authentication/domain/entities/user_entity.dart';
import 'package:booking_services/features/authentication/domain/repository/authentication_repository.dart';
import 'package:dartz/dartz.dart';

class LoginUseCase extends UseCase<UserEntity, LoginParams> {
  AuthenticationRepository authenticationRepository;

  LoginUseCase({required this.authenticationRepository});

  @override
  Future<Either<Failure, UserEntity>> call(
      {required LoginParams params}) async {
    return await authenticationRepository.signInWithEmailAndPassword(
        email: params.email, password: params.password);
  }
}

class LoginParams {
  final String email;
  final String password;

  LoginParams({
    required this.email,
    required this.password,
  });
}
