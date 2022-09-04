import 'package:booking_services/core/base_use_cases.dart';
import 'package:booking_services/core/errors/failures.dart';
import 'package:booking_services/features/booking/domain/booking_repository.dart';
import 'package:booking_services/features/booking/domain/entities/booking_entity.dart';
import 'package:dartz/dartz.dart';

class GetBookingsUseCase extends UseCaseNoParams<List<BookingEntity>> {
  final BookingRepository bookingRepository;

  GetBookingsUseCase({required this.bookingRepository});

  @override
  Future<Either<Failure, List<BookingEntity>>> call() async {
    return await bookingRepository.getBookings();
  }
}
