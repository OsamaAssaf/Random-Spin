import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:random_spin/utils/resources/color_manager.dart';

ThemeData getApplicationTheme() {
  const String fontFamilyEn = 'Ysabeau';
  const String fontFamilyAr = 'Cairo';
  return ThemeData(
    useMaterial3: true,
    fontFamily: fontFamilyEn,
    fontFamilyFallback: const [
      fontFamilyAr,
    ],
    colorScheme: ColorScheme.fromSwatch().copyWith(
      primary: ColorManager.primary,
      secondary: ColorManager.secondary,
      background: ColorManager.white,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: ColorManager.white,
      foregroundColor: ColorManager.primary,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontFamily: fontFamilyEn,
        fontFamilyFallback: const [
          fontFamilyAr,
        ],
        fontSize: 20.0,
        fontWeight: FontWeight.w600,
        color: ColorManager.primary,
        letterSpacing: 1.5,
      ),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: ColorManager.primary,
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: ColorManager.secondary,
    ),
    dividerTheme: DividerThemeData(
      color: ColorManager.grey,
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManager.primary,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManager.primary,
        ),
      ),
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      elevation: 0.0,
    ),
    textTheme: TextTheme(
      bodyLarge: const TextStyle(
        fontSize: 22.0,
        fontWeight: FontWeight.w800,
        fontStyle: FontStyle.italic,
        letterSpacing: 2.0,
      ),
      bodyMedium: const TextStyle(
        fontSize: 18.0,
      ),
      bodySmall: const TextStyle(
        fontSize: 16.0,
      ),
      displayLarge: TextStyle(
        fontSize: 24.0,
        fontWeight: FontWeight.w800,
        fontStyle: FontStyle.italic,
        letterSpacing: 2.0,
        color: ColorManager.white,
      ),
      displayMedium: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.w600,
        color: ColorManager.white,
      ),
      displaySmall: const TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.w800,
        letterSpacing: 1.5,
      ),
      labelSmall: const TextStyle(
        fontSize: 14.0,
        fontStyle: FontStyle.italic,
      ),
    ),
  );
}
