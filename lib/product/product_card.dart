import 'package:flutter/material.dart';
import 'package:shopping_cart/core/utils/theme/text_theme.dart';
import 'package:shopping_cart/core/utils/theme/theme.dart';
import 'package:shopping_cart/product/product_details.dart';

import 'domain/entities/product.dart';

//card of product details
class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    // The GestureDetector wraps the entire card so the tap works on the whole item
    return GestureDetector(
      onTap:
          () => Navigator.pushNamed(
            context,
            ProductDetailsPage.route,
            arguments: product,
          ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // The image section, which has an AspectRatio, should provide a height.
          // Let's ensure it's not trying to take infinite height in some hidden way.
          Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.transparent, width: 2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: AspectRatio(
                    aspectRatio:
                        1, // This means width == height for the image area
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
                    Icons.favorite_border_rounded,
                    size: 20,
                    color: Colors.brown,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8), // Spacer for text
          Row(
            children: [
              // This Text widget might be the one causing issues if it needs infinite width
              // without a flexible parent.
              // To handle long product names gracefully, you can wrap it in Expanded
              // or ensure it has an overflow property.
              Expanded(
                // Ensure Text takes available space but doesn't overflow
                child: Text(
                  product.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                  overflow:
                      TextOverflow
                          .ellipsis, // Add overflow handling for long names
                  maxLines: 1, // Limit to one line
                ),
              ),
              const SizedBox(width: 4), // Small space before star
              Icon(Icons.star_rate_rounded, color: Colors.amber, size: 24),
              Text(
                product.rating.toString(),
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
      ),
    );
  }
}

//
// import 'package:flutter/material.dart';
// import 'package:shopping_cart/core/utils/theme/text_theme.dart';
// import 'package:shopping_cart/core/utils/theme/theme.dart';
// import 'package:shopping_cart/product/data/models/category_model.dart';
// import 'package:shopping_cart/product/product_details.dart';
//
// import 'domain/entities/product.dart';
//
// //card of product details
// class ProductCard extends StatelessWidget {
//   final Product product;
//   // final CategoryModel categoryModel;
//
//   const ProductCard({
//     super.key,
//     required this.product,
//     // required this.categoryModel,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Stack(
//           children: [
//             GestureDetector(
//               onTap:
//                   () => Navigator.pushNamed(
//                     context,
//                     ProductDetailsPage.route,
//                     arguments: {'product': product},
//                   ),
//               child: Container(
//                 decoration: BoxDecoration(
//                   border: Border.all(
//                     color: Colors.transparent,
//                     width: 2, // Border width
//                   ),
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(10),
//                   child: AspectRatio(
//                     aspectRatio: 1,
//                     child: Image.network(product.imageUrl, fit: BoxFit.cover),
//                   ),
//                 ),
//               ),
//             ),
//             Positioned(
//               top: 8,
//               right: 8,
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   shape: BoxShape.circle,
//                 ),
//                 padding: const EdgeInsets.all(6),
//                 child: const Icon(
//                   Icons.favorite_border_rounded,
//                   size: 20,
//                   color: Colors.brown,
//                 ),
//               ),
//             ),
//           ],
//         ),
//         const SizedBox(height: 8),
//         Row(
//           children: [
//             Text(
//               product.name,
//               style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
//             ),
//             const Spacer(),
//             Icon(Icons.star_rate_rounded, color: Colors.amber, size: 24),
//             SizedBox(width: 4),
//             Text(
//               product.rating.toString(),
//               style: TTextTheme.lightTextTheme.bodyMedium?.copyWith(
//                 color: AppColors.grey2,
//               ),
//             ),
//           ],
//         ),
//         const SizedBox(height: 4),
//
//         Text(
//           "\$${product.price}",
//           style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
//         ),
//       ],
//     );
//   }
// }
