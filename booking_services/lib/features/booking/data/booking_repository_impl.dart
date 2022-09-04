import 'package:booking_services/core/errors/error_handler.dart';
import 'package:booking_services/core/errors/failures.dart';
import 'package:booking_services/features/booking/data/data_sources/booking_remote_data_source.dart';
import 'package:booking_services/features/booking/data/models/bookings_model.dart';
import 'package:booking_services/features/booking/domain/booking_repository.dart';
import 'package:booking_services/features/booking/domain/entities/booking_entity.dart';
import 'package:dartz/dartz.dart';

class BookingRepositoryImpl extends BookingRepository with ErrorHandler {
  final BookingRemoteDataSource bookingRemoteDataSource;

  BookingRepositoryImpl({required this.bookingRemoteDataSource});

  @override
  Future<Either<Failure, List<BookingEntity>>> getBookings() async {
    try {
      var result = await bookingRemoteDataSource.getCollection();
      return Right(result);
    } on Exception catch (error) {
      return Left(mapCommonExceptionToFailure(error));
    }
  }

  @override
  Future<Either<Failure, void>> addNewBooking(
      BookingEntity bookingEntity) async {
    try {
      await bookingRemoteDataSource
          .addNewBooking(BookingModel.fromEntity(bookingEntity));
      return const Right(null);
    } on Exception catch (error) {
      return Left(mapCommonExceptionToFailure(error));
    }
  }
}
