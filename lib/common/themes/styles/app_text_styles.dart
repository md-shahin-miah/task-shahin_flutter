import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'app_colors.dart';

/// Custom text styles for the app
class AppTextStyles {
  static const double height = 1.4;

  // static TextStyle base = GoogleFonts.lato(
  //   textStyle: const TextStyle(
  //     height: height,
  //   ),
  // );
  static TextStyle base = const TextStyle(
    fontFamily: "Satoshi",
    height: height,
  );

  static TextStyle h1 = base.copyWith(
    fontSize: 34,
    fontWeight: FontWeight.w600,
    color: AppColors.textColorBlack2,
  );

  static TextStyle h2 = base.copyWith(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    color: AppColors.textColorBlack2,
  );
  static TextStyle h20 = base.copyWith(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.textColorBlack2,
  );

  static TextStyle h3 = base.copyWith(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.textColorBlack2,
  );

  static TextStyle p1 = base.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.textColorBlack2,
  );

  static TextStyle p2 = base.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );

  static TextStyle p3 = base.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.textColorBlack2,
  );

  static TextStyle p4 = base.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );

  static TextStyle p5 = base.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );

  static TextStyle p6 = base.copyWith(
    fontSize: 12,
    fontWeight: FontWeight.w400,

  );
  static TextStyle p7 = base.copyWith(
    fontSize: 10,
    fontWeight: FontWeight.w400,

  );


  static TextStyle purple14 = base.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: Colors.purple,
  );


  static TextStyle bold = base.copyWith(
    fontWeight: FontWeight.bold,
  );

  static TextStyle bold16 = base.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );

  /// Add more [TextStyle]s below
}
