import 'package:booking_calendar/booking_calendar.dart';
import 'package:booking_services/features/booking/domain/entities/booking_entity.dart';
import 'package:booking_services/features/booking/presentation/bloc/booking_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

mixin BookingsHomePageFunction {
  final now = DateTime.now();

  Stream<dynamic>? getBookingStreamMock(
      {required DateTime end, required DateTime start}) {
    return Stream.value([]);
  }

  Future<dynamic> uploadBookingMock(
      {required BookingService newBooking,
      required BookingBloc bookingBloc}) async {
    print(newBooking.userId);
    BookingEntity newBookingEntity = BookingEntity(
      userName: newBooking.userName ?? "",
      email: newBooking.userEmail ?? "",
      phoneNumber: newBooking.userPhoneNumber ?? "",
      placeAddress: "",
      userId: newBooking.userId ?? "",
      bookingStart: Timestamp.fromDate(newBooking.bookingStart),
      bookingEnd: Timestamp.fromDate(newBooking.bookingEnd),
      createAt: DateTime.now().toString(),
    );
    bookingBloc.add(AddNewBookingEvent(newBooking: newBookingEntity));
    await Future.delayed(const Duration(seconds: 1));
    converted.add(DateTimeRange(
        start: newBooking.bookingStart, end: newBooking.bookingEnd));
    print('${newBooking.toJson()} has been uploaded');
  }

  List<DateTimeRange> converted = [];

  List<DateTimeRange> convertStreamResultMock(
      {required dynamic streamResult,
      required BookingService mockBookingService}) {
    ///here you can parse the streamresult and convert to [List<DateTimeRange>]
    DateTime first = now;
    if (mockBookingService.bookingStart.compareTo(now) <= 0) {
      converted
          .add(DateTimeRange(start: mockBookingService.bookingStart, end: now));
    }

    converted.addAll(streamResult);
    return converted;
  }

  List<DateTimeRange> generatePauseSlots() {
    return [
      DateTimeRange(
          start: DateTime(now.year, now.month, now.day, 12, 0),
          end: DateTime(now.year, now.month, now.day, 13, 0))
    ];
  }
}
