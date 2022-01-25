import 'package:flutter/material.dart';

class CustomTheme {
  static ThemeData get lightTheme {
    Color background = const Color(0xFFFFFFFF);
    Color primary = const Color(0xff716cfe);
    Color primaryVariant = const Color(0xffc382ff);
    Color secondary = const Color(0xff252454);
    Color secondaryVariant = const Color(0xff4b48a9);

    return ThemeData(
      backgroundColor: Colors.white,
      scaffoldBackgroundColor: background,
      appBarTheme: AppBarTheme(backgroundColor: primary),
      colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: primary,
          secondary: secondary,
          secondaryVariant: secondaryVariant,
          primaryVariant: primaryVariant),
    );
  }
}
