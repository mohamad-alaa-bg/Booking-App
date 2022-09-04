import 'package:booking_services/core/errors/failures.dart';
import 'package:dartz/dartz.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call({required Params params});
}

abstract class UseCaseNoParams<Type> {
  Future<Either<Failure, Type>> call();
}

abstract class UseCaseNoFuture<Type, Params> {
  Either<Fail, Type> call({Params params});
}

abstract class UseCaseNoFutureNoParams<Type> {
  Either<Failure, Type> call();
}

abstract class UseCaseStream<Type> {
  Stream<Either<Failure, Type>> call();
}
