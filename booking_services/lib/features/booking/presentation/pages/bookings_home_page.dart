import 'package:booking_calendar/booking_calendar.dart';
import 'package:booking_services/features/authentication/domain/entities/user_entity.dart';
import 'package:booking_services/features/authentication/presentation/Bloc/authentication_bloc.dart';
import 'package:booking_services/features/booking/presentation/pages/bookings_home_page_function.dart';
import 'package:booking_services/features/booking/presentation/pages/my_bookings_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../authentication/presentation/Pages/authentication_page.dart';
import '../bloc/booking_bloc.dart';

class BookingsHomePage extends StatefulWidget {
  final UserEntity? user;

  const BookingsHomePage({Key? key, this.user}) : super(key: key);

  @override
  State<BookingsHomePage> createState() => _BookingsHomePageState();
}

class _BookingsHomePageState extends State<BookingsHomePage>
    with BookingsHomePageFunction {
  late BookingBloc bookingBloc;
  late AuthenticationBloc authenticationBloc;
  late BookingService mockBookingService;

  @override
  void initState() {
    bookingBloc = BlocProvider.of<BookingBloc>(context);
    bookingBloc.add(GetBookingsDatesEvent());
    mockBookingService = BookingService(
        userName: widget.user?.name ?? '',
        userPhoneNumber: widget.user?.phoneNum ?? '',
        userEmail: widget.user?.email ?? '',
        userId: widget.user?.userId ?? '',
        serviceName: 'Mock Service',
        serviceDuration: 60,
        bookingEnd: DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day, 23, 59),
        bookingStart: DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day, 8, 0));
    FirebaseFirestore.instance
        .collection('Bookings')
        .where(
          "createAt",
          isGreaterThanOrEqualTo:
              DateTime(now.year, now.month, now.day).toString(),
        )
        .snapshots()
        .listen((event) {
      bookingBloc.add(RefreshBookingDatesEvent(docs: event.docs));
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking Calendar'),
        actions: [
          IconButton(
            padding: EdgeInsets.zero,
            icon: const Icon(Icons.calendar_month_sharp),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyBookingsPage(
                      bookingList: bookingBloc.bookingList,
                      userId: widget.user?.userId ?? '',
                    ),
                  ));
            },
          ),
          const SizedBox(
            width: 5,
          ),
          IconButton(
            padding: EdgeInsets.zero,
            icon: const Icon(Icons.logout),
            onPressed: () {
              BlocProvider.of<AuthenticationBloc>(context).add(LogoutEvent());
            },
          ),
        ],
      ),
      body: Center(
        child: BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context1, state) {
            if (state is LogoutSuccessfullyState) {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AuthenticationPage(),
                  ));
            }
          },
          child: BlocBuilder<BookingBloc, BookingState>(
            builder: (context, state) {
              return state is BookingsIsLoadingState
                  ? const CircularProgressIndicator()
                  : state is BookingsLoadedSuccessfullyState
                      ? BookingCalendar(
                          bookingService: mockBookingService,
                          convertStreamResultToDateTimeRanges: (
                                  {required dynamic streamResult}) =>
                              convertStreamResultMock(
                            streamResult: state.bookingsList,
                            mockBookingService: mockBookingService,
                          ),
                          getBookingStream: getBookingStreamMock,
                          uploadBooking: (
                                  {required BookingService newBooking}) =>
                              uploadBookingMock(
                                  newBooking: newBooking,
                                  bookingBloc: bookingBloc),
                          pauseSlots: generatePauseSlots(),
                          pauseSlotText: 'LUNCH',
                          hideBreakTime: false,
                          loadingWidget: const Text('Fetching data...'),
                          uploadingWidget: const CircularProgressIndicator(),
                          locale: 'En',
                          startingDayOfWeek: StartingDayOfWeek.saturday,
                          bookedSlotColor:
                              const Color.fromRGBO(200, 200, 200, 0.5),
                          availableSlotColor:
                              Colors.greenAccent.withOpacity(0.8),
                          pauseSlotColor: Colors.white70.withOpacity(.1),
                          bookingButtonColor:
                              const Color.fromRGBO(44, 44, 83, .8),
                        )
                      : state is BookingsLoadedErrorState
                          ? Text(state.errorMessage)
                          : Container();
            },
          ),
        ),
      ),
    );
  }
}
