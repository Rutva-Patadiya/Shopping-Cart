import 'package:flutter/material.dart';
import 'package:shopping_cart/l10n/translation_extension.dart';
import 'package:shopping_cart/product/domain/entities/product.dart';
import 'package:shopping_cart/widgets/custom_chips.dart';

import '../core/utils/theme/text_theme.dart';

class SelectedSize extends StatefulWidget {
  final Product product;
  final List<String> sizes;
  final String? selectedSize;

  const SelectedSize({
    super.key,
    required this.product,
    required this.sizes,
    this.selectedSize,
  });

  @override
  State<StatefulWidget> createState() => _SelectSizeState();
}

class _SelectSizeState extends State<SelectedSize> {
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
          padding: const EdgeInsets.only(left: 16, top: 8),
          child: Text(
            context.loc.selectSize,
            style: TTextTheme.lightTextTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children:
                  widget.sizes.map((size) {
                    // Use widget.sizes here
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: CustomChips(
                        label: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            size,
                            style: TTextTheme.lightTextTheme.labelSmall
                                ?.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color:
                                      widget.selectedSize == size
                                          ? Colors.white
                                          : Colors.black,
                                ),
                          ),
                        ),
                        onTap: () {
                          setState(() {});
                        },
                        backgroundColor:
                            widget.selectedSize == size
                                ? Colors.brown
                                : Colors.white,
                        height: 40,
                      ),
                    );
                  }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
