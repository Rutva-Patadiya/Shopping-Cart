import 'package:flutter/material.dart';

class ActionChip extends StatelessWidget {
  final Widget label;
  final VoidCallback onPressed;
  final Color backgroundColor;

  const ActionChip({
    super.key,
    required this.label,
    required this.onPressed,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      backgroundColor: Colors.white,
      label: label,
      onPressed: () {
        onPressed();
      },
    );
  }
}
