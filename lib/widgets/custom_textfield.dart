import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../core/utils/theme/text_theme.dart';

class CustomTextField extends StatelessWidget {
  final String? label;
  final TextInputType? keyboardType;
  final bool obscureText;
  final IconData prefixIcon;
  final TextEditingController controller;
  final String hint;
  final FormFieldValidator? validator;
  final TextStyle? hintStyle;
  final Widget? suffixIcon;

  // final double? width;

  const CustomTextField({
    super.key,
    required this.label,
    required this.keyboardType,
    required this.hint,
    required this.hintStyle,
    required this.obscureText,
    required this.controller,
    required this.prefixIcon,
    required this.suffixIcon,
    required this.validator,
    // required this.width,
  });

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 4, left: 2),
          child: Text(
            label ?? ' ',
            style:
            // style: TextTheme.of(
            //   context,
            // ).titleLarge?.copyWith(fontFamily: 'Poppins-Light'),
            TTextTheme.lightTextTheme.headlineLarge?.copyWith(
              fontFamily: 'Poppins-Light',
            ),
          ),
        ),
        // SizedBox(height: 5),
        TextFormField(
          keyboardType: keyboardType,
          obscureText: obscureText,
          validator: validator,
          controller: controller,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          //to validate when user interacts
          cursorColor: Colors.blueAccent,
          style: TTextTheme.lightTextTheme.bodyLarge,

          decoration: InputDecoration(
            isDense: true,
            // labelText: label,
            hintText: hint,
            hintStyle: hintStyle,
            prefixIcon: Padding(
              padding: EdgeInsets.only(top: 1),
              child: Icon(prefixIcon, color: Colors.grey, size: 25),
            ),
            suffixIcon: suffixIcon,
            border: OutlineInputBorder(),
          ),
        ),
      ],
    );
  }
}
