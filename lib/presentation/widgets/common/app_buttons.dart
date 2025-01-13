import 'package:flutter/material.dart';
import 'package:shahin_appify_task/core/themes/styles/app_colors.dart';
import 'package:shahin_appify_task/core/themes/styles/app_shadows.dart';
import 'package:shahin_appify_task/core/themes/styles/app_text_styles.dart';

class AppButtons {
  static Widget primary({
    required VoidCallback? onTap,
    required Widget child,
    double? width,
    Color? fillColor,
    Color? textColor,
  }) {
    final decoration = BoxDecoration(
      color: fillColor ?? (onTap == null ? Colors.grey[300] : AppColors.primary),
      border: Border.all(
        color: fillColor ?? (onTap == null ? Colors.grey[300]! : AppColors.primary),
      ),
      borderRadius: BorderRadius.circular(12),
      boxShadow: [AppShadows.primary],
    );

    return Ink(
      decoration: decoration,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        highlightColor: textColor?.withOpacity(0.15) ?? AppColors.text.withOpacity(0.15),
        child: SizedBox(
          height: 50,
          width: width ?? double.infinity,
          child: Center(
            child: DefaultTextStyle.merge(
              style: AppTextStyles.bold.copyWith(color: textColor ?? AppColors.white),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}



class CustomButton extends StatelessWidget {
  final String btnText;
  final double? width;
  final double? textSize;
  final Color bgColor;
  final VoidCallback? toggleObscure;

  const CustomButton({
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

