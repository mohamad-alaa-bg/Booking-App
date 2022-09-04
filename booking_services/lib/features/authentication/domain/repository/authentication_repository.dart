import 'package:booking_services/core/errors/failures.dart';
import 'package:booking_services/features/authentication/domain/entities/user_entity.dart';
import 'package:dartz/dartz.dart';

abstract class AuthenticationRepository {
  Future<Either<Failure, UserEntity>> signInWithEmailAndPassword(
      {required String email, required String password});

  Future<Either<Failure, UserEntity>> createUserWithEmailAndPassword(
      {required String email,
      required String password,
      required String username,
      required String phoneNum});

  Either<Failure, dynamic> logout();
}
