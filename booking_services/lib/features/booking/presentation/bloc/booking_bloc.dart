import 'package:booking_services/features/booking/domain/entities/booking_entity.dart';
import 'package:booking_services/features/booking/domain/usecases/get_bookings_usecases.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/bookings_model.dart';
import '../../domain/usecases/add_new_booking.dart';

part 'booking_event.dart';
part 'booking_state.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  final GetBookingsUseCase getBookingsUseCase;
  final AddNewBookingUseCase addNewBookingUseCase;

  BookingBloc({
    required this.getBookingsUseCase,
    required this.addNewBookingUseCase,
  }) : super(BookingInitial()) {
    on<BookingEvent>((event, emit) async {
      if (event is GetBookingsDatesEvent) {
        await _getBookings(emit);
      }
      if (event is AddNewBookingEvent) {
        await _addNewBooking(event.newBooking, emit);
      }
      if (event is RefreshBookingDatesEvent) {
        List<BookingModel> bookingsList = [];
        for (var element in event.docs) {
          bookingsList.add(BookingModel.fromJson(element.data()));
        }
        bookingList = bookingsList;
        List<DateTimeRange> bookingsList1 = bookingsList.map((e) {
          DateTime start = DateTime.fromMicrosecondsSinceEpoch(
              e.bookingStart.microsecondsSinceEpoch);
          DateTime end = DateTime.fromMicrosecondsSinceEpoch(
              e.bookingEnd.microsecondsSinceEpoch);

          return DateTimeRange(start: start, end: end);
        }).toList();
        emit(BookingsLoadedSuccessfullyState(bookingsList: bookingsList1));
      }
    });
  }
  late List<BookingEntity> bookingList;
  Future<void> _getBookings(Emitter<BookingState> emit) async {
    emit(BookingsIsLoadingState());
    var result = await getBookingsUseCase();
    result.fold((l) => emit(BookingsLoadedErrorState(errorMessage: l.message)),
        (r) {
      bookingList = r;
      List<DateTimeRange> bookingsList = r.map((e) {
        DateTime start = DateTime.fromMicrosecondsSinceEpoch(
            e.bookingStart.microsecondsSinceEpoch);
        DateTime end = DateTime.fromMicrosecondsSinceEpoch(
            e.bookingEnd.microsecondsSinceEpoch);

        return DateTimeRange(start: start, end: end);
      }).toList();
      emit(BookingsLoadedSuccessfullyState(bookingsList: bookingsList));
    });
  }

  Future<void> _addNewBooking(
      BookingEntity newBooking, Emitter<BookingState> emit) async {
    await addNewBookingUseCase(params: newBooking);
  }
}
