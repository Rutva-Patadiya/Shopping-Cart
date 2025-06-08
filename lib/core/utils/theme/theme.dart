import 'package:flutter/material.dart';
import 'package:shopping_cart/core/utils/theme/progress_indicator.dart';
import 'package:shopping_cart/core/utils/theme/text_theme.dart';

import 'elevated_button_theme.dart';
import 'input_decoration.dart';

class AppColors {
  static const Color bgAccent = Color(0xFF1976D2); //blue700 border focus
  static const Color border = Color(0XFFD6D6D6); //grey300
  static const Color grey2 = Color(0xFF9E9E9E); //grey button
  static const Color greyColor = Color(0xFFBDBDBD); //grey button
  static const Color lightGrey = Color(0xFFF7F7F7);
  static const Color grey = Color(0xFFEEEEEE);
  static const Color blue = Color(0XFF2196F3);
  static const Color skyBlue = Color(0XFF304FFF);
  static const Color brown = Colors.brown;
  static const Color cream = Color(0xFFEEE5DB);
  static const Color lightBrown = Color(0xFFF7F2ED);
  static const Color lightYellow = Color(0XFFFFFDE7);
  static const Color lightBlue = Color(0xFF82B1FF);
  static const Color lightPurple = Color(0xFF8D9CFF);
  static const Color lightCream = Color(0xFFf4f3ef);
  static const Color creamColor = Color(0xFFefefed);
  static const Color darkBlue = Color(0xFF586CFF);
  static const Color ashColor = Color(0xFFE8E8E8);
  static const Color yellow = Color(0xFFF9A825);
  static const Color lYellow = Color(0xFFFFF9C5);
  static const Color lPurple = Color(0xFFD1C4E9);
  static const Color green = Color(0xFF63B067);
  static const Color lGreen = Color(0xFFD7E6D8);
  static const Color darkGreen = Color(0xFF1B5E20);
  static const Color darkRed = Color(0xFFC13F40);
  static const Color orange = Color(0xFFFB8F0B);
  static const Color lOrange = Color(0xFFFFF2E1);
  static const Color black = Color(0xFF424242);
}

class TAppTheme {
  TAppTheme._();

  static ThemeData lightTheme = ThemeData(
    textTheme: TTextTheme.lightTextTheme,
    fontFamily: 'Poppins',
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    elevatedButtonTheme: TElevatedButtonTheme.lightElevatedButtonTheme,
    inputDecorationTheme: TInputDecoration.lightInputDecorationTheme,
    progressIndicatorTheme: TProgressIndicator.lightProgressIndicatorTheme,
  );
}
