import 'package:flutter/material.dart';

import '../core/utils/theme/text_theme.dart';
import '../core/utils/theme/theme.dart';

//dropdownbutton for location selection in home page
class DropDownButton extends StatefulWidget {
  const DropDownButton({super.key});

  @override
  State<DropDownButton> createState() => _DropdownButtonState();
}

class _DropdownButtonState extends State<DropDownButton> {
  String? selectedValue = "New York, USA";

  @override
  Widget build(context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Icon(Icons.location_on, color: AppColors.brown),
        ),
        DropdownButton(
          dropdownColor: Colors.white,
          borderRadius: BorderRadius.circular(10),
          icon: Icon(Icons.expand_more, size: 22, color: Colors.black87),
          iconSize: 24,
          value: selectedValue,
          isDense: true,
          //reduce the button's default height
          underline: Container(),
          items: [
            DropdownMenuItem(
              value: "New York, USA",
              child: Text(
                "New York, USA",
                style: TTextTheme.lightTextTheme.labelMedium,
              ),
            ),
            DropdownMenuItem(
              value: "London, UK",
              child: Text(
                "London, UK",
                style: TTextTheme.lightTextTheme.labelMedium,
              ),
            ),

            DropdownMenuItem(
              value: "Tokyo, Japan",
              child: Text(
                "Tokyo, Japan",
                style: TTextTheme.lightTextTheme.labelMedium,
              ),
            ),
          ],
          onChanged: (value) {
            setState(() {
              selectedValue = value!;
            });
          },
        ),
      ],
    );
  }
}
