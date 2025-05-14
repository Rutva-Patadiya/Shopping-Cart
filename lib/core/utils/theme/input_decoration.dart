import 'package:flutter/material.dart';
import 'package:shopping_cart/core/utils/theme/theme.dart';

class TInputDecoration {
  TInputDecoration._();

  static InputDecorationTheme lightInputDecorationTheme = InputDecorationTheme(
    // hintStyle: TTextTheme.lightTextTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700),
    // hintStyle: TTextTheme.lightTextTheme.bodySmall?.copyWith(color:Colors.black38),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: Colors.blue),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(width: 1, color: AppColors.border),
    ),

    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(width: 2, color: AppColors.bgAccent),
    ),

    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(width: 2, color: Colors.redAccent),
    ),

    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(width: 2, color: Colors.redAccent),
    ),
  );
}
