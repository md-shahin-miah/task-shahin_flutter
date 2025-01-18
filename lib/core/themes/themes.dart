import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shahin_appify_task/core/themes/styles/app_colors.dart';
import 'package:shahin_appify_task/core/themes/styles/app_text_styles.dart';




class AppThemes {
  static ThemeData primary({bool isDark = false}) => ThemeData(
        useMaterial3: true,
        primaryColor: AppColors.primaryColor,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.indigo,
        ),
        scaffoldBackgroundColor: AppColors.background,
        // backgroundColor: AppColors.background,
        cardColor: AppColors.white,
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          },
        ),
        // textTheme: TextTheme(
        //   headline1: AppTextStyles.h1,
        //   headline2: AppTextStyles.h2,
        //   headline3: AppTextStyles.h3,
        //   bodyText1: AppTextStyles.p1,
        //   bodyText2: AppTextStyles.p2,
        //   subtitle1: AppTextStyles.p3,
        //   subtitle2: AppTextStyles.p4,
        //   headline5: AppTextStyles.p5,
        //   caption: AppTextStyles.p6,
        // ),
        appBarTheme: AppBarTheme(
          elevation: 0,
          backgroundColor: AppColors.background,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          iconTheme: const IconThemeData(color: AppColors.primaryColor),
          titleTextStyle: AppTextStyles.h3.copyWith(
            color: AppColors.textColorBlack2,
          ),
        ),
        tabBarTheme: TabBarTheme(
          indicator: BoxDecoration(
            border: Border.all(width: 0, color: Colors.transparent),
          ),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: AppColors.white,
        ),
        splashFactory: defaultTargetPlatform == TargetPlatform.iOS ? NoSplash.splashFactory : InkSplash.splashFactory,
      );
}
