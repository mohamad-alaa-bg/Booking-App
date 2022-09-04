import 'package:booking_services/features/booking/data/booking_repository_impl.dart';
import 'package:booking_services/features/booking/data/data_sources/booking_remote_data_source.dart';
import 'package:booking_services/features/booking/domain/booking_repository.dart';
import 'package:booking_services/features/booking/domain/usecases/add_new_booking.dart';
import 'package:booking_services/features/booking/domain/usecases/get_bookings_usecases.dart';
import 'package:booking_services/features/booking/presentation/bloc/booking_bloc.dart';
import 'package:get_it/get_it.dart';

Future<void> getBookingDependency(GetIt sl) async {
  sl.registerFactory<BookingRemoteDataSource>(
      () => BookingRemoteDataSourceImpl());
  sl.registerFactory<BookingRepository>(
      () => BookingRepositoryImpl(bookingRemoteDataSource: sl()));
  sl.registerFactory<GetBookingsUseCase>(
      () => GetBookingsUseCase(bookingRepository: sl()));
  sl.registerFactory<AddNewBookingUseCase>(
      () => AddNewBookingUseCase(bookingRepository: sl()));
  sl.registerFactory(
      () => BookingBloc(getBookingsUseCase: sl(), addNewBookingUseCase: sl()));
}
