import 'package:flutter/material.dart';

import '../../../config/themes/styles/app_colors.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool isPassword;
  final bool? obscureText;
  final VoidCallback? toggleObscure;

  const CustomTextField({
    required this.controller,
    required this.hintText,
    required this.isPassword,
    this.obscureText,
    this.toggleObscure,
    Key? key, required bool isBorder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText ?? false,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.fillColor,
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.grey),
        suffixIcon: isPassword
            ? IconButton(
          icon: Icon(
            obscureText! ? Icons.visibility_off : Icons.visibility,
            color: Colors.white,
          ),
          onPressed: toggleObscure,
        )
            : null,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.blue),
        ),
      ),
    );
  }
}