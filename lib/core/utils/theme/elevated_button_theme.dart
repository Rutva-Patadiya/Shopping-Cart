import 'package:flutter/material.dart';
import 'package:shopping_cart/core/utils/theme/text_theme.dart';
import 'package:shopping_cart/core/utils/theme/theme.dart';

class TElevatedButtonTheme {
  TElevatedButtonTheme._();

  static final lightElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(textStyle: TTextTheme.lightTextTheme.bodyLarge?.copyWith(
        fontWeight: FontWeight.bold,
        letterSpacing: 1.3,
        ),

        foregroundColor: Colors.white,
        padding: EdgeInsets.only(top: 10),
        minimumSize: const Size(350, 50),
        backgroundColor: AppColors.bgAccent
      ),
    );


}
