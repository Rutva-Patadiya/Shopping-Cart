import 'package:flutter/material.dart';

class CustomChips extends StatelessWidget {
  final Text label;
  final Color? backgroundColor;
  final double height;
  final double width;

  const CustomChips({
    super.key,
    required this.label,
    required this.backgroundColor,
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return ChipTheme(
      data: ChipTheme.of(
        context,
      ).copyWith(backgroundColor: backgroundColor ?? Colors.white),
      child: SizedBox(
        height: height,

        child: Chip(label: Center(child: label), labelPadding: EdgeInsets.zero),
      ),
    );
  }
}
