import 'package:flutter/material.dart';

class CustomChips extends StatelessWidget {
  final Text label;
  final Color? backgroundColor;
  final double height;
  final double width;
  final VoidCallback? onTap;

  const CustomChips({
    super.key,
    required this.label,
    required this.backgroundColor,
    required this.height,
    required this.width,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ChipTheme(
        data: ChipTheme.of(
          context,
        ).copyWith(backgroundColor: backgroundColor ?? Colors.white),
        child: SizedBox(
          height: height,

          child: Chip(
            label: Center(child: label),
            labelPadding: EdgeInsets.zero,
          ),
        ),
      ),
    );
  }
}
