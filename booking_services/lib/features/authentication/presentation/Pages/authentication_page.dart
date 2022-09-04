import 'package:booking_services/core/common/snack_bar.dart';
import 'package:booking_services/features/authentication/presentation/Bloc/authentication_bloc.dart';
import 'package:booking_services/features/authentication/presentation/Pages/login_page.dart';
import 'package:booking_services/features/authentication/presentation/Pages/signUp_page.dart';
import 'package:booking_services/features/booking/presentation/pages/bookings_home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthenticationPage extends StatelessWidget {
  const AuthenticationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        initialIndex: 0,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Home Page'),
            elevation: 0,
          ),
          body: Align(
            child: Scaffold(
              appBar: AppBar(
                toolbarHeight: 40,
                elevation: 0,
                backgroundColor: Colors.transparent,
                titleSpacing: 0,
                title: TabBar(
                  labelPadding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  unselectedLabelColor: Colors.grey,
                  indicator: BoxDecoration(
                      color: const Color.fromRGBO(44, 44, 83, 100),
                      borderRadius: BorderRadius.circular(5)
                      // borderRadius: BorderRadius.circular(15),
                      ),
                  tabs: const [
                    Text(
                      "Login",
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      "Signup",
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
              body: BlocListener<AuthenticationBloc, AuthenticationState>(
                listener: (context, state) {
                  if (state is LoginSuccessfullyState) {
                    context.showSuccessSnackBar(
                        resourceKey: 'Login Successfully');
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BookingsHomePage(
                            user: state.user,
                          ),
                        ));
                  } else if (state is SignUpSuccessfullyState) {
                    context.showSuccessSnackBar(
                        resourceKey: 'SignUp Successfully');
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BookingsHomePage(
                            user: state.user,
                          ),
                        ));
                  } else if (state is AuthErrorState) {
                    context.showErrorSnackBar(message: state.message);
                  }
                  // TODO: implement listener
                },
                child: const TabBarView(children: [
                  LoginPage(),
                  SignUp(),
                ]),
              ),
            ),
          ),
        ));
  }
}
