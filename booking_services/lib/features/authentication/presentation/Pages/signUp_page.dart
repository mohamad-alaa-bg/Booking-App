import 'package:booking_services/features/authentication/presentation/Bloc/authentication_bloc.dart';
import 'package:booking_services/features/authentication/presentation/Widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUp extends StatelessWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController? passwordController = TextEditingController();
    TextEditingController? usernameController = TextEditingController();
    TextEditingController? phoneNumController = TextEditingController();
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomTextFormField(
                controller: emailController,
                label: 'Email',
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextFormField(
                controller: passwordController,
                label: 'Password',
                obscureText: true,
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextFormField(
                controller: usernameController,
                label: 'Username',
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextFormField(
                controller: phoneNumController,
                label: 'Phone Number',
              ),
              const SizedBox(
                height: 40,
              ),
              BlocBuilder<AuthenticationBloc, AuthenticationState>(
                builder: (context, state) {
                  return SizedBox(
                    width: 200,
                    height: 45,
                    child: ElevatedButton(
                      onPressed: () {
                        var authBloc =
                            BlocProvider.of<AuthenticationBloc>(context);
                        authBloc.add(SignUpEvent(
                            email: emailController.text,
                            password: passwordController.text,
                            username: usernameController.text,
                            phoneNum: phoneNumController.text));
                      },
                      child: state is LoadingState
                          ? const CircularProgressIndicator()
                          : const Text('SignUp'),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
