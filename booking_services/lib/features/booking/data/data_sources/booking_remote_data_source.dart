import 'package:booking_services/core/errors/exceptions.dart';
import 'package:booking_services/features/booking/data/models/bookings_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class BookingRemoteDataSource {
  Future<List<BookingModel>> getCollection();

  Future<void> addNewBooking(BookingModel bookingModel);
}

class BookingRemoteDataSourceImpl extends BookingRemoteDataSource {
  @override
  Future<List<BookingModel>> getCollection() async {
    DateTime now = DateTime.now();
    var query = await FirebaseFirestore.instance
        .collection('Bookings')
        .where(
          "createAt",
          isGreaterThanOrEqualTo:
              DateTime(now.year, now.month, now.day).toString(),
        )
        // .where("userId ", isEqualTo: re.userId)
        .get()
        .catchError((error) {
      if (error.toString().contains("permission-denied")) {
        print(error.toString());
        throw UnauthorizedException(
            message: "Missing or insufficient permissions");
      }
      print(error.toString());
      throw UnhandledException(message: error.toString());
    });
    List<BookingModel> bookingsList = [];
    for (var element in query.docs) {
      bookingsList.add(BookingModel.fromJson(element.data()));
    }
    return bookingsList;
  }

  @override
  Future<void> addNewBooking(BookingModel bookingModel) async {
    var bookingCollection = FirebaseFirestore.instance.collection('Bookings');
    await bookingCollection.add(bookingModel.toJson());
  }
}
