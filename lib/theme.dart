import 'package:flutter/material.dart';

class LightThemeColor {
  static const primaryColor = Color(0xff217CF3);
  static const secondaryColor = Color(0xff262A35);
  static const primaryTextColor = Color(0xff262A35);
  static const secondaryTextColor = Color(0xffB3B6BE);
}

class AppTheme {
  static const defaultTextStyle = TextStyle(fontFamily: "IranYekan");
  static ThemeData lightTheme = ThemeData(
    snackBarTheme: const SnackBarThemeData(contentTextStyle: defaultTextStyle),
    textTheme: TextTheme(
      titleMedium: defaultTextStyle.copyWith(
        fontSize: 14,
        color: LightThemeColor.secondaryTextColor,
      ),
      labelLarge:
          defaultTextStyle.apply(color: LightThemeColor.secondaryTextColor),
      bodyMedium: defaultTextStyle,
      titleLarge:
          defaultTextStyle.copyWith(fontWeight: FontWeight.bold, fontSize: 15),
      bodySmall:
          defaultTextStyle.apply(color: LightThemeColor.secondaryTextColor),
    ),
    colorScheme: const ColorScheme.light(
        primary: LightThemeColor.primaryColor,
        secondary: LightThemeColor.secondaryColor,
        onSecondary: Colors.white),
    primarySwatch: Colors.blue,
  );
}
