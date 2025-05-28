import 'package:flutter/material.dart';
import 'package:shopping_cart/core/utils/theme/text_theme.dart';
import 'package:shopping_cart/core/utils/theme/theme.dart';

import 'domain/entities/product.dart';

//card of product details
class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.transparent,
                  // Change this to your desired border color
                  width: 2, // Border width
                ),
                borderRadius: BorderRadius.circular(10),
              ),

              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Image.network(product.imageUrl, fit: BoxFit.cover),
                ),
              ),
            ),
            Positioned(
              top: 8,
              right: 8,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                padding: const EdgeInsets.all(6),
                child: const Icon(
                  Icons.favorite_border,
                  size: 20,
                  color: Colors.brown,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Text(
              product.name,
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
            ),
            const Spacer(),
            Icon(Icons.star_rate_rounded, color: Colors.amber, size: 24),
            SizedBox(width: 4),
            Text(
              "4.9",
              style: TTextTheme.lightTextTheme.bodyMedium?.copyWith(
                color: AppColors.grey2,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),

        Text(
          "\$${product.price}",
          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
        ),
      ],
    );
  }
}
