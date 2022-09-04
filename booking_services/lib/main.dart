import 'package:booking_services/core/dependency_register/dependencies.dart';
import 'package:booking_services/features/authentication/data/data_sources/authentication_local_data_source.dart';
import 'package:booking_services/features/authentication/domain/entities/user_entity.dart';
import 'package:booking_services/features/authentication/presentation/Bloc/authentication_bloc.dart';
import 'package:booking_services/features/authentication/presentation/Pages/authentication_page.dart';
import 'package:booking_services/features/booking/presentation/bloc/booking_bloc.dart';
import 'package:booking_services/features/booking/presentation/pages/bookings_home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await slInit();
  var local = sl<AuthenticationLocalDataSource>();
  UserEntity? user;
  bool isLoggedIn = local.isLoggedIn();
  if (isLoggedIn) {
    user = await local.getCashedUse();
  }
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  initializeDateFormatting().then((_) => runApp(BookingCalendarApp(
        isLoggedIn: isLoggedIn,
        user: user,
      )));
}

class BookingCalendarApp extends StatelessWidget {
  final bool isLoggedIn;
  final UserEntity? user;

  const BookingCalendarApp({Key? key, required this.isLoggedIn, this.user})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<BookingBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<AuthenticationBloc>(),
        ),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Booking Calendar',
          theme: ThemeData(
              appBarTheme:
                  const AppBarTheme(color: Color.fromRGBO(203, 49, 97, 100)),
              primaryColor: const Color.fromRGBO(252, 107, 33, 100),
              indicatorColor: const Color.fromRGBO(44, 44, 83, 100),
              elevatedButtonTheme: ElevatedButtonThemeData(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          const Color.fromRGBO(252, 107, 33, 100))))
              // cardColor: Color.fromRGBO(44, 44, 83, 100),
              ),
          home: isLoggedIn
              ? BookingsHomePage(user: user)
              : const AuthenticationPage()),
    );
  }
}
