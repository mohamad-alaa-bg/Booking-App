part of 'booking_bloc.dart';

@immutable
abstract class BookingState {}

class BookingInitial extends BookingState {}

class BookingsIsLoadingState extends BookingState {}

class BookingsLoadedSuccessfullyState extends BookingState {
  final List<DateTimeRange> bookingsList;

  BookingsLoadedSuccessfullyState({required this.bookingsList});
}

class BookingsLoadedErrorState extends BookingState {
  final String errorMessage;

  BookingsLoadedErrorState({required this.errorMessage});
}
