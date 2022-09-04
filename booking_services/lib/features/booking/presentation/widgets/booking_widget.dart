import 'package:booking_services/features/booking/domain/entities/booking_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BookingWidget extends StatelessWidget {
  final BookingEntity bookingEntity;

  const BookingWidget({Key? key, required this.bookingEntity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String _getDateTime({
      required Timestamp time,
      bool getDate = false,
    }) {
      DateTime dateTime =
          DateTime.fromMicrosecondsSinceEpoch(time.microsecondsSinceEpoch);
      if (getDate) {
        return DateFormat('dd-MM-yyyy').format(dateTime);
      }
      return DateFormat('hh-mm a').format(dateTime);
    }

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color.fromRGBO(44, 44, 83, 100).withOpacity(.2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _getDateTime(time: bookingEntity.bookingStart, getDate: true),
            style: const TextStyle(color: Color.fromRGBO(203, 49, 97, 100)),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    const Text('Start'),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(_getDateTime(time: bookingEntity.bookingStart)),
                  ],
                ),
                Icon(
                  Icons.arrow_forward_outlined,
                  color: Theme.of(context).primaryColor,
                ),
                Column(
                  children: [
                    const Text('End'),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(_getDateTime(time: bookingEntity.bookingEnd)),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
