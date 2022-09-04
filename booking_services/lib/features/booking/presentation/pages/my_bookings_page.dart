import 'package:booking_services/features/booking/domain/entities/booking_entity.dart';
import 'package:booking_services/features/booking/presentation/widgets/booking_widget.dart';
import 'package:flutter/material.dart';

class MyBookingsPage extends StatelessWidget {
  final List<BookingEntity> bookingList;
  final String userId;

  const MyBookingsPage(
      {Key? key, required this.bookingList, required this.userId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<BookingEntity> bookingsList = [];
    for (var element in bookingList) {
      if (element.userId == userId) {
        bookingsList.add(element);
      }
    }
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView.separated(
            separatorBuilder: (context, index) => const SizedBox(
                  height: 10,
                ),
            itemBuilder: (context, index) => BookingWidget(
                  bookingEntity: bookingsList[index],
                ),
            itemCount: bookingsList.length),
      ),
    );
  }
}
