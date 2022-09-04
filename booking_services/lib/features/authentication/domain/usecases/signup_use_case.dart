import 'package:booking_services/core/base_use_cases.dart';
import 'package:booking_services/core/errors/failures.dart';
import 'package:booking_services/features/authentication/domain/entities/user_entity.dart';
import 'package:booking_services/features/authentication/domain/repository/authentication_repository.dart';
import 'package:dartz/dartz.dart';

class SignupUseCase extends UseCase<UserEntity, SignupParams> {
  AuthenticationRepository authenticationRepository;

  SignupUseCase({required this.authenticationRepository});

  @override
  Future<Either<Failure, UserEntity>> call(
      {required SignupParams params}) async {
    return await authenticationRepository.createUserWithEmailAndPassword(
        email: params.email,
        password: params.password,
        username: params.username,
        phoneNum: params.phoneNum);
  }
}

class SignupParams {
  final String email;
  final String password;
  final String username;
  final String phoneNum;

  SignupParams({
    required this.email,
    required this.password,
    required this.username,
    required this.phoneNum,
  });
}
