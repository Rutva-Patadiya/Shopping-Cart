import 'package:flutter/material.dart';
import 'package:shopping_cart/core/utils/theme/theme.dart';

class CustomChips extends StatelessWidget {
  final Text label;
  final Color? backgroundColor;
  final double height;
  final VoidCallback? onTap;

  const CustomChips({
    super.key,
    required this.label,
    required this.backgroundColor,
    required this.height,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        height: height,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: backgroundColor ?? Colors.white,
          borderRadius: BorderRadius.circular(8), // Adjust as needed
          border: Border.all(color: AppColors.grey),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            left: 10,
            top: 2,
            right: 10,
            bottom: 2,
          ),
          child: label,
        ),
      ),
    );
  }
}
