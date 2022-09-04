import 'package:booking_services/features/booking/domain/entities/booking_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BookingModel extends BookingEntity {
  @override
  final String userName;
  @override
  final String email;
  @override
  final String phoneNumber;
  @override
  final String placeAddress;
  @override
  final String userId;
  @override
  final Timestamp bookingStart;
  @override
  final Timestamp bookingEnd;
  @override
  final String createAt;

  BookingModel({
    required this.userName,
    required this.email,
    required this.phoneNumber,
    required this.placeAddress,
    required this.userId,
    required this.bookingStart,
    required this.bookingEnd,
    required this.createAt,
  }) : super(
            userName: userName,
            email: email,
            phoneNumber: phoneNumber,
            placeAddress: placeAddress,
            userId: userId,
            bookingStart: bookingStart,
            bookingEnd: bookingEnd,
            createAt: createAt);

  factory BookingModel.fromJson(Map<String, dynamic> booking) {
    return BookingModel(
      userName: booking['userName'] ?? '',
      email: booking['email'] ?? '',
      phoneNumber: booking['phoneNumber'] ?? '',
      placeAddress: booking['placeAddress'] ?? '',
      userId: booking['userId'] ?? '',
      bookingStart: booking['bookingStart'] ??
          Timestamp.fromDate(DateTime(2022, 8, 31, 10)),
      bookingEnd: booking['bookingEnd'] ??
          Timestamp.fromDate(DateTime(2022, 8, 31, 11)),
      createAt: booking['createAt'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        "userName": userName,
        "email": email,
        "phoneNumber": phoneNumber,
        "placeAddress": placeAddress,
        "userId": userId,
        "bookingStart": bookingStart,
        "bookingEnd": bookingEnd,
        "createAt": DateTime.now().toString(),
      };

  factory BookingModel.fromEntity(BookingEntity booking) {
    return BookingModel(
      userName: booking.userName,
      email: booking.email,
      phoneNumber: booking.phoneNumber,
      placeAddress: booking.placeAddress,
      userId: booking.userId,
      bookingStart: booking.bookingStart,
      bookingEnd: booking.bookingEnd,
      createAt: booking.createAt,
    );
  }
}
