import 'package:flutter/material.dart';

class AppColors {


  //primary
  static const Color primaryColor = Color(0xFF115C67);
  static const primaryLightColor = Color(0xff6debff);
  static const Color primaryDark = Color.fromARGB(255, 1, 0, 128);

  //secondary
  static const Color secondaryColors = Color(0xffE8F54A);
  static const secondaryDarkColor = Color(0xff00a459);
  static const secondaryLightColor = Color(0xff62ffb7);


//txt
  static const primaryTextColor = Color(0xffffffff);
  static const secondaryTextColor = Color(0xffffffff);
  static const Color textColorGray = Color(0xFF989898);
  static const Color textColorGray2 = Color(0xFFE0E0E0);
  static const Color textColorBlack2 = Color(0xFF161616);



  //common
  static const Color black = Color(0xff121212);
  static const Color background = Color(0xfff2f2f2);
  static const Color white = Color(0xffffffff);
  static const Color lightGray = Color(0xffcccccc);
  static const Color gray = Color(0xffcccccc);
  static const Color darkerGray = Color(0xFFD3D3D3);
  static const Color colorError = Color(0xFFE50000);
  static const shadowColor = Color(0x4D000000);
  static const Color colorBlue = Color(0xFF1976D2);
  static const Color backgroundColor = Color(0xFFF8F8F8);
  static const Color dotColor = Color(0xFFD6A0F9);
  static const Color starColor = Color(0xFFFF9900);




  //fill color

  static const fillColor = Color(0x20FFFFFF);
  static const fillColor2 = Color(0x20FFFFFF);
  static const fillColor3 = Color(0x20868686);

  static const LinearGradient primaryGradient = LinearGradient(
    begin: AlignmentDirectional.centerStart,
    end: AlignmentDirectional.centerEnd,
    colors: [
      primaryColor,
      primaryDark,
    ],
  );
}
