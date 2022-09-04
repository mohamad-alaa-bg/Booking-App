import 'package:booking_services/core/base_use_cases.dart';
import 'package:booking_services/core/errors/failures.dart';
import 'package:booking_services/features/booking/domain/booking_repository.dart';
import 'package:booking_services/features/booking/domain/entities/booking_entity.dart';
import 'package:dartz/dartz.dart';

class AddNewBookingUseCase extends UseCase<void, BookingEntity> {
  final BookingRepository bookingRepository;

  AddNewBookingUseCase({required this.bookingRepository});

  @override
  Future<Either<Failure, void>> call({required BookingEntity params}) async {
    return await bookingRepository.addNewBooking(params);
  }
}
