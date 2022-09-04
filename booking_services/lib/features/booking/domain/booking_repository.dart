import 'package:booking_services/core/errors/failures.dart';
import 'package:booking_services/features/booking/domain/entities/booking_entity.dart';
import 'package:dartz/dartz.dart';

abstract class BookingRepository {
  Future<Either<Failure, List<BookingEntity>>> getBookings();

  Future<Either<Failure, void>> addNewBooking(BookingEntity bookingEntity);
}
