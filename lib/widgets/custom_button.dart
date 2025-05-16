import 'package:flutter/material.dart';

import '../core/utils/theme/theme.dart';

class CustomButton extends StatelessWidget {
  final String name;
  final VoidCallback onPressed;
  final bool isSelected;

  const CustomButton({
    super.key,
    required this.name,
    required this.onPressed,
    required this.isSelected, //to check whether that button is selected or not
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(2),
            ),
            backgroundColor: isSelected ? AppColors.bgAccent : AppColors.grey,
            // Override background color
            foregroundColor: isSelected ? Colors.white : Colors.black,
            // Override text/icon color
            minimumSize: Size(30, 40),
            // Override size
            textStyle: TextStyle(
              fontWeight: FontWeight.normal,
              letterSpacing: 0.5,
            ),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          ),
          onPressed: () {
            onPressed();
          },
          child: Text(name),
        ),
      ),
    );
  }
}
