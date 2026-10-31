import 'package:flutter/material.dart';
import 'package:shoply_app/core/utils/fonts/app_fonts.dart';
import 'package:shoply_app/core/utils/theme/app_colors.dart';

class AppTheme {
  static ThemeData themeLight = ThemeData(
    fontFamily: AppFonts.quikSand,
    scaffoldBackgroundColor: AppColors.backgrroundLight,
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.primaryColor,
      onPrimary: AppColors.onPrimary,
      secondary: AppColors.primaryColor,
      onSecondary: AppColors.onPrimary,
      error: AppColors.error,
      onError: AppColors.onError,
      surface: AppColors.backgrroundLight,
      onSurface: Colors.black,
    ),
    radioTheme: RadioThemeData(fillColor: WidgetStatePropertyAll(Colors.black)),
    iconTheme: IconThemeData(color: Colors.black),
    listTileTheme: ListTileThemeData(
      iconColor: Colors.black,
      textColor: Colors.black,
    ),
    textTheme: TextTheme(
      bodyMedium: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.bold,
        color: Colors.black,
        fontStyle: FontStyle.normal,
      ),
      bodySmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w700,
        color: Colors.black,
      ),
    ),
  );

  static ThemeData themeDark = ThemeData(
    fontFamily: AppFonts.quikSand,
    scaffoldBackgroundColor: AppColors.backgrrounDark,
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.primaryColor,
      onPrimary: AppColors.onPrimary,
      secondary: AppColors.primaryColor,
      onSecondary: AppColors.onPrimary,
      error: AppColors.error,
      onError: AppColors.onError,
      surface: AppColors.backgrrounDark,
      onSurface: Colors.white,
    ),
    radioTheme: RadioThemeData(fillColor: WidgetStatePropertyAll(Colors.white)),
    listTileTheme: ListTileThemeData(
      iconColor: Colors.white,
      textColor: Colors.white,
    ),
    iconTheme: IconThemeData(color: Colors.white),
    textTheme: TextTheme(
      bodySmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w700,
        color: Colors.white,
      ),
      bodyMedium: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.bold,
        color: Colors.white,
        fontStyle: FontStyle.normal,
      ),
    ),
  );
}
