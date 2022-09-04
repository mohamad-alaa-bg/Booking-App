import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String? label;
  final TextEditingController? controller;
  final bool obscureText;

  const CustomTextFormField(
      {Key? key, this.label, this.controller, this.obscureText = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
            label: Text(label ?? ''),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(14))));
  }
}
