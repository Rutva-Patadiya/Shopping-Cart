import 'package:flutter/material.dart';

class TTextTheme {
  TTextTheme._();

  static TextTheme lightTextTheme = TextTheme(
    titleMedium: TextStyle(fontSize: 32),
    displayLarge: TextStyle(fontSize: 28),

    displayMedium: TextStyle(fontSize: 24),
    displaySmall: TextStyle(fontSize: 22),

    headlineLarge: TextStyle(fontSize: 20),
    headlineSmall: TextStyle(fontSize: 18),

    bodyLarge: TextStyle(fontSize: 16),

    bodyMedium: TextStyle(fontSize: 14),

    bodySmall: TextStyle(fontSize: 12),

    labelLarge: TextStyle(fontSize: 16),

    //grey text button
    labelMedium: TextStyle(fontSize: 14),
    labelSmall: TextStyle(fontSize: 12),
  );

  static TextTheme darkTextTheme = TextTheme(
    displayLarge: TextStyle(fontSize: 28),
    displayMedium: TextStyle(fontSize: 24),
    displaySmall: TextStyle(fontSize: 22),

    headlineLarge: TextStyle(fontSize: 20, color: Colors.white),
    headlineSmall: TextStyle(fontSize: 18, color: Colors.white),

    bodyLarge: TextStyle(fontSize: 16),
    bodyMedium: TextStyle(fontSize: 14),
    bodySmall: TextStyle(fontSize: 12, color: Colors.white),

    labelLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w100,
      color: Colors.white,
    ),

    //grey text button
    labelMedium: TextStyle(fontSize: 14, color: Colors.black54),
    labelSmall: TextStyle().copyWith(
      fontSize: 12,
      fontWeight: FontWeight.w100,
      color: Colors.white,
    ),
  );
}
