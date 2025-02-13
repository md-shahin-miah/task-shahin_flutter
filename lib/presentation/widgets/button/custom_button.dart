import 'package:flutter/material.dart';
import 'package:shahin_appify_task/core/themes/styles/app_colors.dart';

import '../../../common/themes/styles/app_colors.dart';

class CustomPrimaryButton extends StatelessWidget {
  final String btnText;
  final double? width;
  final double? textSize;
  final Color bgColor;
  final VoidCallback? toggleObscure;

  const CustomPrimaryButton({
    required this.btnText,
    this.textSize = 18,
    this.toggleObscure,
    required this.bgColor,
    this.width = double.infinity,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: toggleObscure,
        child: Text(
          btnText,
          style: TextStyle(fontSize: textSize, color: AppColors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
