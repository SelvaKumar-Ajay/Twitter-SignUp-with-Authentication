import 'package:flutter/material.dart';

import '../../../theme/theme.dart';

class AuthReusableTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  const AuthReusableTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscureText,
      controller: controller,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: const BorderSide(
            color: Pallete.blueColor,
            width: 3.0,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: const BorderSide(
            color: Pallete.greyColor,
          ),
        ),
        hintText: hintText,
        hintStyle: const TextStyle(fontSize: 18.0),
        contentPadding: const EdgeInsets.all(22.0),
      ),
    );
  }
}
