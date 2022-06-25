import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lovely_coffee/application/styles/color_styles.dart';
import 'package:lovely_coffee/application/styles/heading_styles.dart';

ThemeData themeStyles() {
  return ThemeData(
    scaffoldBackgroundColor: const Color(0XFFFFFFFF),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: Colors.white,
      systemOverlayStyle: SystemUiOverlayStyle.light,
      iconTheme: IconThemeData(color: Color(0XFF424242)),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      prefixIconColor: ColorStyles.textFieldIcon,
      suffixIconColor: ColorStyles.textFieldIcon,
      errorStyle: HeadingStyles.heading14Bold.copyWith(
        color: ColorStyles.errorMessage,
      ),
      hintStyle: HeadingStyles.heading14Normal.copyWith(
        color: ColorStyles.textFieldHint,
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          width: 1.5,
          color: ColorStyles.textFieldNormalBorder,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          width: 1.5,
          color: ColorStyles.textFieldFocusBorder,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          width: 1.5,
          color: ColorStyles.textFieldErrorBorder,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          width: 1.5,
          color: ColorStyles.textFieldFocusBorder,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        onPrimary: ColorStyles.titleButton1,
        textStyle: HeadingStyles.heading16Bold,
        primary: ColorStyles.backgroundButton1,
        onSurface: ColorStyles.backgroundButton1,
        minimumSize: const Size(0, 48.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    ),
  );
}
