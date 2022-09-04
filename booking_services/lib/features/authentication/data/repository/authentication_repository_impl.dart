import 'package:booking_services/core/errors/error_handler.dart';
import 'package:booking_services/core/errors/failures.dart';
import 'package:booking_services/features/authentication/data/data_sources/authentication_local_data_source.dart';
import 'package:booking_services/features/authentication/data/data_sources/authentication_remote_data_source.dart';
import 'package:booking_services/features/authentication/domain/entities/user_entity.dart';
import 'package:booking_services/features/authentication/domain/repository/authentication_repository.dart';
import 'package:dartz/dartz.dart';

class AuthenticationRepositoryImpl extends AuthenticationRepository
    with ErrorHandler {
  AuthRemoteDataSource authRemoteDataSource;
  AuthenticationLocalDataSource authenticationLocalDataSource;

  AuthenticationRepositoryImpl(
      {required this.authRemoteDataSource,
      required this.authenticationLocalDataSource});

  @override
  Future<Either<Failure, UserEntity>> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      var loginResult = await authRemoteDataSource.signInWithEmailAndPassword(
          email: email, password: password);
      var result = await authRemoteDataSource.getUser(email: email);
      authenticationLocalDataSource.cashedUser(
          user: result, token: loginResult.token);
      return Right(result);
    } on Exception catch (error) {
      return Left(mapCommonExceptionToFailure(error));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> createUserWithEmailAndPassword(
      {required String email,
      required String password,
      required String username,
      required String phoneNum}) async {
    try {
      var result = await authRemoteDataSource.createUseWithEmailAndPassword(
          email: email,
          password: password,
          username: username,
          phoneNum: phoneNum);
      authenticationLocalDataSource.cashedUser(
          user: result, token: result.token);
      return Right(result);
    } on Exception catch (error) {
      return Left(mapCommonExceptionToFailure(error));
    }
  }

  @override
  Either<Failure, dynamic> logout() {
    return authenticationLocalDataSource.logOut()
        ? const Right(true)
        : left(mapCommonExceptionToFailure(Exception('error')));
  }
}
