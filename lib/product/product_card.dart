import 'package:flutter/material.dart';

import 'domain/entities/product.dart';

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
                  color: Colors.brown,
                  // Change this to your desired border color
                  width: 2, // Border width
                ),
                borderRadius: BorderRadius.circular(10),
              ),

              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Image.network(
                    product.imageUrl,

                    // fit: BoxFit.cover,
                  ),
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
                  color: Colors.black,
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
            Text(
              "\$${product.price}",
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          children: const [
            Icon(Icons.star, color: Colors.amber, size: 16),
            SizedBox(width: 4),
            Text("4.9", style: TextStyle(fontSize: 14)),
          ],
        ),
      ],
    );
  }
}
