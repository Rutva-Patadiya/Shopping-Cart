import 'package:flutter/material.dart';
import 'package:shopping_cart/product/domain/entities/product.dart';
import 'package:shopping_cart/widgets/custom_chips.dart';

import '../core/utils/theme/text_theme.dart';
import 'data/models/category_model.dart';

class SelectedSize extends StatefulWidget {
  final Product product;
  final CategoryModel category;

  const SelectedSize({
    super.key,
    required this.product,
    required this.category,
  });

  @override
  State<StatefulWidget> createState() => _SelectSizeState();
}

class _SelectSizeState extends State<SelectedSize> {
  @override
  // String? selectedSize;
  @override
  Widget build(BuildContext context) {
    return Row(
      children:
          widget.category.size.map((size) {
            return CustomChips(
              label: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  size,
                  style: TTextTheme.lightTextTheme.labelSmall?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              // selected: selectedSize == size,
              onTap: () {
                setState(() {
                  // selectedSize = isSelected ? size : null;
                });
              },
              backgroundColor: Colors.white,
              height: 40,
            );
          }).toList(),
    );
  }

  // Widget build(BuildContext context) {
  //   return Column(
  //     children: [
  //       Row(
  //         children: [
  //           Padding(
  //             padding: const EdgeInsets.only(left: 16, top: 2),
  //             child: Text(
  //               context.loc.selectSize,
  //               style: TTextTheme.lightTextTheme.bodyLarge?.copyWith(
  //                 fontWeight: FontWeight.w500,
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //
  //       Padding(
  //         padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
  //         child: Row(children: []),
  //       ),
  //     ],
  //   );
  // }
}

// SizedBox(width: 4),
// CustomChips(
//   onTap:
//       () => setState(() {
//         // selectedSize = "S";
//       }),
//   label: Text(
//     widget.product.size,
//     style: TTextTheme.lightTextTheme.labelSmall?.copyWith(
//       fontWeight: FontWeight.w500,
//       // height: -0.8,
//       // color: selectedSize == "S" ? Colors.white : Colors.black,
//     ),
//   ),
//   backgroundColor: Colors.white,
//   // selectedSize == "S" ? AppColors.brown : Colors.white,
//   height: 32,
// ),
// CustomChips(
//   onTap:
//       () => setState(() {
//         // selectedSize = "M";
//       }),
//   label: Text(
//     "M",
//     style: TTextTheme.lightTextTheme.labelSmall?.copyWith(
//       fontWeight: FontWeight.w500,
//       // height: -0.8,
//       // color: selectedSize == "M" ? Colors.white : Colors.black,
//     ),
//   ),
//   backgroundColor: Colors.white,
//   height: 32,
// ),
// CustomChips(
//   onTap:
//       () => setState(() {
//         // selectedSize = "L";
//       }),
//   label: Text(
//     "L",
//     style: TTextTheme.lightTextTheme.labelSmall?.copyWith(
//       fontWeight: FontWeight.w500,
//       // height: -0.8,
//       // color: selectedSize == "L" ? Colors.white : Colors.black,
//     ),
//   ),
//   backgroundColor: Colors.white,
//   // selectedSize == "L" ? AppColors.brown : Colors.white,
//   height: 32,
// ),
//
// CustomChips(
//   onTap:
//       () => setState(() {
//         // selectedSize = "XL";
//       }),
//   label: Text(
//     "XL",
//     style: TTextTheme.lightTextTheme.labelSmall?.copyWith(
//       fontWeight: FontWeight.w500,
//       // height: -0.8,
//       // color: selectedSize == "XL" ? Colors.white : Colors.black,
//     ),
//   ),
//   backgroundColor: Colors.white,
//   // selectedSize == "XL" ? AppColors.brown : Colors.white,
//   height: 32,
// ),
// // SizedBox(width: 8),
// CustomChips(
//   onTap:
//       () => setState(() {
//         // selectedSize = "XXL";
//       }),
//   label: Text(
//     "XXL",
//     style: TTextTheme.lightTextTheme.labelSmall?.copyWith(
//       fontWeight: FontWeight.w500,
//       // height: -0.9,
//       // color: selectedSize == "XXL" ? Colors.white : Colors.black,
//     ),
//   ),
//   backgroundColor: Colors.white,
//   // selectedSize == "XXL" ? AppColors.brown : Colors.white,
//   height: 32,
// ),
// // SizedBox(width: 14),
// CustomChips(
//   onTap:
//       () => setState(() {
//         // selectedSize = "XXXL";
//       }),
//   label: Text(
//     "XXXL",
//     style: TTextTheme.lightTextTheme.labelSmall?.copyWith(
//       fontWeight: FontWeight.w500,
//       // height: -0.9,
//       // color: selectedSize == "XXXL" ? Colors.white : Colors.black,
//     ),
//   ),
//   backgroundColor: Colors.white,
//   // selectedSize == "XXXL" ? AppColors.brown : Colors.white,
//   height: 32,
// ),
