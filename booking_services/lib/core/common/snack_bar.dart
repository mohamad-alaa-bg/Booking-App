import 'package:flutter/material.dart';

extension CustomSnackBar on BuildContext {
  void showErrorSnackBar({String message = ""}) {
    ScaffoldMessenger.of(this).removeCurrentSnackBar();
    ScaffoldMessenger.of(this).showSnackBar(_snackBarWidget(
      message: message,
      backgroundColor: Colors.red.shade900.withOpacity(0.9),
    ));
  }

  void showSuccessSnackBar({String? resourceKey}) {
    ScaffoldMessenger.of(this).removeCurrentSnackBar();
    ScaffoldMessenger.of(this).showSnackBar(_snackBarWidget(
      message: resourceKey ?? "success_message",
      backgroundColor: Colors.greenAccent.withOpacity(0.9),
    ));
  }

  void showNotifySnackBar({String message = ""}) {
    ScaffoldMessenger.of(this).removeCurrentSnackBar();
    ScaffoldMessenger.of(this).showSnackBar(_snackBarWidget(
      message: message,
      backgroundColor: Colors.orangeAccent.withOpacity(0.9),
    ));
  }

  SnackBar _snackBarWidget(
          {required String message, required Color backgroundColor}) =>
      SnackBar(
        content: Text(
          message,
        ),
        backgroundColor: backgroundColor,
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
      );
}
