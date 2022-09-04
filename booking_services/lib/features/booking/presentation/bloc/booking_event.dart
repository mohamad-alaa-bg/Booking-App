part of 'booking_bloc.dart';

@immutable
abstract class BookingEvent {}

class GetBookingsDatesEvent extends BookingEvent {}

class RefreshBookingDatesEvent extends BookingEvent {
  final List<QueryDocumentSnapshot<Map<String, dynamic>>> docs;
  RefreshBookingDatesEvent({required this.docs});
}

class AddNewBookingEvent extends BookingEvent {
  final BookingEntity newBooking;

  AddNewBookingEvent({required this.newBooking});
}
