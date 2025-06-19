import 'package:flutter/material.dart';

import '../core/utils/theme/text_theme.dart';
import '../widgets/custom_chips.dart';

class VariantChipList extends StatelessWidget {
  final String title;
  final List<String> items;

  const VariantChipList({super.key, required this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16, top: 8),
          child: Text(title, style: TTextTheme.lightTextTheme.bodyLarge),
        ),
        SizedBox(
          height: 40,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: items.length,
            itemBuilder: (context, index) {
              return CustomChips(
                label: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(items[index]),
                ),
                backgroundColor: Colors.white,
                onTap: () {},
                height: 40,
              );
            },
          ),
        ),
      ],
    );
  }
}
