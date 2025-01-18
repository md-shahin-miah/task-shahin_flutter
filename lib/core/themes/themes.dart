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
        textTheme: TextTheme(
          displayLarge: AppTextStyles.h1,
          displayMedium: AppTextStyles.h2,
          displaySmall: AppTextStyles.h3,
          bodyLarge: AppTextStyles.p1,
          bodyMedium: AppTextStyles.p2,
          titleMedium: AppTextStyles.p3,
          titleSmall: AppTextStyles.p4,
          headlineSmall: AppTextStyles.p5,
          bodySmall: AppTextStyles.p6,
        ),
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
