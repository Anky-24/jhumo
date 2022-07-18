import 'package:flutter/material.dart';
import 'constants/colors.dart';

class JhumoTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: primaryL,
      colorScheme: const ColorScheme.light(secondary: secondaryL),
      canvasColor: ternaryL,
      textTheme: const TextTheme(
        headline1: TextStyle(
          fontFamily: 'Lato',
          fontWeight: FontWeight.w900,
          color: white,
        ),
        headline2: TextStyle(
          fontFamily: 'Lato',
          fontWeight: FontWeight.w700,
          color: white,
        ),
        bodyText1: TextStyle(
          fontFamily: 'Lato',
          fontSize: 18,
          color: white,
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      primaryColor: primaryL,
      colorScheme: const ColorScheme.light(secondary: secondaryL),
      canvasColor: ternaryL,
      textTheme: const TextTheme(
        headline1: TextStyle(
          fontFamily: 'Lato',
          fontWeight: FontWeight.w900,
          color: white,
        ),
        headline2: TextStyle(
          fontFamily: 'Lato',
          fontWeight: FontWeight.w700,
          color: white,
        ),
        bodyText1: TextStyle(
          fontFamily: 'Lato',
          fontSize: 18,
          color: white,
        ),
      ),
    );
  }
}
