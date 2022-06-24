import 'package:flutter/material.dart';
import 'package:lovely_coffee/application/styles/color_styles.dart';
import 'package:lovely_coffee/application/styles/heading_styles.dart';

ThemeData themeStyles() {
  return ThemeData(
    scaffoldBackgroundColor: const Color(0XFFFFFFFF),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: HeadingStyles.heading14Normal,
      errorStyle: HeadingStyles.heading14Bold,
      prefixIconColor: ColorStyles.textFieldIcon,
      suffixIconColor: ColorStyles.textFieldIcon,
      constraints: const BoxConstraints(maxHeight: 48),
      border: OutlineInputBorder(
        borderSide: const BorderSide(
          width: 2.0,
          color: ColorStyles.textFieldNormalBorder,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorStyles.textFieldNormalBorder,
        ),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorStyles.textFieldFocusBorder,
        ),
      ),
      errorBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorStyles.textFieldErrorBorder,
        ),
      ),
      focusedErrorBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorStyles.textFieldFocusBorder,
        ),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        onPrimary: ColorStyles.titleButton1,
        textStyle: HeadingStyles.heading16Bold,
        primary: ColorStyles.backgroundButton1,
        onSurface: ColorStyles.backgroundButton1,
        fixedSize: const Size(double.infinity, 48.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    ),
  );
}
