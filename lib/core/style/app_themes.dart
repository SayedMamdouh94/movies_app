import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/style/app_colors.dart';

import 'app_font_weight.dart';

class AppThemes {
  AppThemes._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: const ColorScheme.light(
      primary: AppColors.kPrimary,
      secondary: AppColors.kSecondary,
      onPrimary: AppColors.kWhite,
      onSecondary: AppColors.kWhite,
      surface: AppColors.kBackground,
      onSurface: AppColors.kBlack,
      brightness: Brightness.light,
      error: AppColors.kError,
      surfaceContainerHighest: AppColors.kBackground,
    ),
    scaffoldBackgroundColor: AppColors.kBackground,
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.kSecondary,
    ),
    appBarTheme: AppBarTheme(
      surfaceTintColor: AppColors.kBackground,
      centerTitle: false,
      titleTextStyle: TextStyle(
        color: AppColors.kGray900,
        fontSize: 20.sp,
        fontWeight: AppFontWeight.bold,
        fontFamily: 'NotoSansArabic',
      ),
      backgroundColor: AppColors.kBackground,
      elevation: 0,
      iconTheme: const IconThemeData(color: AppColors.kGray900, size: 22),
    ),
    fontFamily: 'NotoSansArabic',
    textTheme: TextTheme(
      titleLarge: TextStyle(
        color: AppColors.kGray950,
        fontSize: 26.sp,
        fontWeight: AppFontWeight.extraBold,
      ),
      titleMedium: TextStyle(
        color: AppColors.kGray950,
        fontSize: 24.sp,
        fontWeight: AppFontWeight.bold,
      ),
      titleSmall: TextStyle(
        color: AppColors.kGray950,
        fontSize: 20.sp,
        fontWeight: AppFontWeight.bold,
      ),
      bodyLarge: TextStyle(
        color: AppColors.kGray950,
        fontSize: 18.sp,
        fontWeight: AppFontWeight.regular,
      ),
      bodyMedium: TextStyle(
        color: AppColors.kGray950,
        fontSize: 16.sp,
        fontWeight: AppFontWeight.regular,
      ),
      bodySmall: TextStyle(
        color: AppColors.kGray950,
        fontSize: 14.sp,
        fontWeight: AppFontWeight.regular,
      ),
      labelLarge: TextStyle(
        color: AppColors.kGray950,
        fontSize: 12.sp,
        fontWeight: AppFontWeight.regular,
      ),
      labelMedium: TextStyle(
        color: AppColors.kGray950,
        fontSize: 10.sp,
        fontWeight: AppFontWeight.regular,
      ),
      labelSmall: TextStyle(
        color: AppColors.kGray950,
        fontSize: 8.sp,
        fontWeight: AppFontWeight.regular,
      ),
    ),
  );
}
