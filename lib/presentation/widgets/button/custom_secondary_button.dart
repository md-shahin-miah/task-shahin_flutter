import 'package:flutter/material.dart';
import 'package:shahin_appify_task/core/themes/styles/app_colors.dart';
import 'package:shahin_appify_task/core/themes/styles/app_shadows.dart';
import 'package:shahin_appify_task/core/themes/styles/app_text_styles.dart';

class CustomSecondaryButton {
  static Widget secondary({
    required VoidCallback? onTap,
    required Widget child,
    double? width,
    Color? fillColor,
    Color? textColor,
  }) {
    final decoration = BoxDecoration(
      color: fillColor ?? (onTap == null ? AppColors.lightGray : AppColors.primaryColor),
      border: Border.all(
        color: fillColor ?? (onTap == null ? AppColors.lightGray : AppColors.primaryColor),
      ),
      borderRadius: BorderRadius.circular(12),
      boxShadow: [AppShadows.primary],
    );

    return Ink(
      decoration: decoration,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        highlightColor: textColor?.withOpacity(0.15) ?? AppColors.primaryTextColor.withOpacity(0.15),
        child: SizedBox(
          height: 50,
          width: width ?? double.infinity,
          child: Center(
            child: DefaultTextStyle.merge(
              style: AppTextStyles.bold.copyWith(color: textColor ?? AppColors.primaryTextColor),
              child: child,
            ),
          ),
        ),
      ),
    );
  }



}
