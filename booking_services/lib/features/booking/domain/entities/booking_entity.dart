import 'package:cloud_firestore/cloud_firestore.dart';

class BookingEntity {
  final String userName;
  final String email;
  final String phoneNumber;
  final String placeAddress;
  final String userId;
  final Timestamp bookingStart;
  final Timestamp bookingEnd;
  final String createAt;

  BookingEntity({
    required this.userName,
    required this.email,
    required this.phoneNumber,
    required this.placeAddress,
    required this.userId,
    required this.bookingStart,
    required this.bookingEnd,
    required this.createAt,
  });
}
