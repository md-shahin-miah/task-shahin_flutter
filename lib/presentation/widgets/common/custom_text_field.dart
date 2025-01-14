import 'package:flutter/material.dart';
import 'package:shahin_appify_task/core/themes/styles/app_colors.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final Color hintColor;
  final Color? textColor;
  final bool isPassword;
  final bool? obscureText;
  final VoidCallback? toggleObscure;
  final bool? isBorder;

  const CustomTextField({
    required this.controller,
    required this.hintText,
    this.textColor,
    required this.isPassword,
    required this.hintColor,
    this.obscureText,
    this.toggleObscure,
    Key? key,
    this.isBorder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText ?? false,
      style: TextStyle(color: textColor ?? AppColors.black),
      decoration: InputDecoration(
        border: isBorder! ? null : InputBorder.none,
        filled: true,
        fillColor: AppColors.fillColor,
        contentPadding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        hintText: hintText,
        hintStyle: TextStyle(color: hintColor),
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(
                  obscureText! ? Icons.visibility_off : Icons.visibility,
                  color: Colors.white,
                ),
                onPressed: toggleObscure,
              )
            : null,
        enabledBorder: isBorder!
            ? OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: AppColors.gray),
              )
            : null,
        focusedBorder: isBorder!
            ? OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Colors.blue),
              )
            : null,
      ),
    );
  }
}
