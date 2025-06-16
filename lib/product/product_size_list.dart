import 'package:flutter/material.dart';
import 'package:shopping_cart/l10n/translation_extension.dart';
import 'package:shopping_cart/product/domain/entities/product.dart';
import 'package:shopping_cart/widgets/custom_chips.dart';

import '../core/utils/theme/text_theme.dart';

class ProductSizeList extends StatefulWidget {
  final Product product;
  final List<String> sizes;
  final String? sizeList;

  const ProductSizeList({
    super.key,
    required this.product,
    required this.sizes,
    this.sizeList,
  });

  @override
  State<StatefulWidget> createState() => _SelectSizeState();
}

class _SelectSizeState extends State<ProductSizeList> {
  @override
  Widget build(BuildContext context) {
    // Check if the sizes list is empty or null before mapping
    if (widget.sizes.isEmpty) {
      return const SizedBox.shrink(); // Don't display anything if no sizes
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16, top: 4),
          child: Text(
            context.loc.selectSize,
            style: TTextTheme.lightTextTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: SizedBox(
            height: 40,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: widget.sizes.length,
              itemBuilder: (context, index) {
                final size = widget.sizes[index];
                return Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: CustomChips(
                    label: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        size,
                        style: TTextTheme.lightTextTheme.labelSmall?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    backgroundColor: Colors.white,
                    height: 40,
                    onTap: () {},
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
