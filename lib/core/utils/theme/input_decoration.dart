import 'package:flutter/material.dart';
import 'package:shopping_cart/core/utils/theme/theme.dart';

class TInputDecoration {
  TInputDecoration._();

  static InputDecorationTheme lightInputDecorationTheme = InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(50),
      borderSide: BorderSide(color: AppColors.grey),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(50),
      borderSide: BorderSide(width: 1, color: AppColors.grey),
    ),

    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(50),
      borderSide: BorderSide(width: 2, color: AppColors.brown),
    ),

    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(50),
      borderSide: BorderSide(width: 2, color: Colors.redAccent),
    ),

    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(50),
      borderSide: BorderSide(width: 2, color: Colors.redAccent),
    ),
  );
}
