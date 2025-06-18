import 'package:flutter/material.dart';
import 'package:shopping_cart/l10n/translation_extension.dart';

import '../core/utils/theme/text_theme.dart';
import '../utils/color_utils.dart';
import 'data/models/product_color_model.dart';
import 'domain/entities/product.dart';

class ProductColorList extends StatelessWidget {
  final Product product;
  final List<ColorItem> colorList;
  final String selectedColor;

  const ProductColorList({
    super.key,
    required this.product,
    required this.colorList,
    required this.selectedColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16, top: 8),
          child: Text(
            context.loc.selectColor,
            style: TTextTheme.lightTextTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 40,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: colorList.length,
            itemBuilder: (context, index) {
              final colorItem = colorList[index];
              final color = getColorFromHex(colorItem.hex);

              final isSelected = colorItem.hex == selectedColor;

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Container(
                  height: 28,
                  width: 28,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: color,
                    border: Border.all(
                      color: isSelected ? Colors.blue : Colors.black12,
                      width: isSelected ? 2 : 1,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
