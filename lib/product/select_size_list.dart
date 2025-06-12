// shopping_cart/product/select_size_list.dart
import 'package:flutter/material.dart';
import 'package:shopping_cart/l10n/translation_extension.dart';
import 'package:shopping_cart/product/domain/entities/product.dart';
import 'package:shopping_cart/widgets/custom_chips.dart';

import '../core/utils/theme/text_theme.dart';
import 'data/models/category_model.dart'; // Ensure this path is correct

class SelectedSize extends StatefulWidget {
  final Product product;
  final CategoryModel category; // This should be uncommented and passed in

  const SelectedSize({
    super.key,
    required this.product,
    required this.category, // This should be uncommented
  });

  @override
  State<StatefulWidget> createState() => _SelectSizeState();
}

class _SelectSizeState extends State<SelectedSize> {
  String? selectedSize; // Uncomment this line to declare the state variable

  @override
  Widget build(BuildContext context) {
    return Column(
      // Wrap in a Column to add a "Select Size" title
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16, top: 8), // Add some padding
          child: Text(
            context.loc.selectSize, // Assuming you have a translation for this
            style: TTextTheme.lightTextTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8), // Adjust padding for the Row of chips
          child: Row(
            children: widget.category.size.map((size) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0), // Spacing between chips
                child: CustomChips(
                  label: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      size,
                      style: TTextTheme.lightTextTheme.labelSmall?.copyWith(
                        fontWeight: FontWeight.w500,
                        // Change text color based on selection
                        color: selectedSize == size ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                  // Set 'selected' property to highlight the chosen chip
                  // selected: selectedSize == size,
                  onTap: () {
                    setState(() {
                      // Toggle selection: if already selected, deselect; otherwise, select
                      selectedSize = (selectedSize == size) ? null : size;
                    });
                  },
                  // Change background color based on selection
                  backgroundColor: selectedSize == size ? Colors.brown : Colors.white,
                  height: 40,
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:shopping_cart/product/domain/entities/product.dart';
// import 'package:shopping_cart/widgets/custom_chips.dart';
//
// import '../core/utils/theme/text_theme.dart';
// import 'data/models/category_model.dart';
//
// class SelectedSize extends StatefulWidget {
//   final Product product;
//   final CategoryModel category;
//
//   const SelectedSize({
//     super.key,
//     required this.product,
//     required this.category,
//   });
//
//   @override
//   State<StatefulWidget> createState() => _SelectSizeState();
// }
//
// class _SelectSizeState extends State<SelectedSize> {
//   @override
//   // String? selectedSize;
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children:
//           widget.category.size.map((size) {
//             return CustomChips(
//               label: Padding(
//                 padding: const EdgeInsets.all(4.0),
//                 child: Text(
//                   size,
//                   style: TTextTheme.lightTextTheme.labelSmall?.copyWith(
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//               ),
//               // selected: selectedSize == size,
//               onTap: () {
//                 setState(() {
//                   // selectedSize = isSelected ? size : null;
//                 });
//               },
//               backgroundColor: Colors.white,
//               height: 40,
//             );
//           }).toList(),
//     );
//   }
//
//   // Widget build(BuildContext context) {
//   //   return Column(
//   //     children: [
//   //       Row(
//   //         children: [
//   //           Padding(
//   //             padding: const EdgeInsets.only(left: 16, top: 2),
//   //             child: Text(
//   //               context.loc.selectSize,
//   //               style: TTextTheme.lightTextTheme.bodyLarge?.copyWith(
//   //                 fontWeight: FontWeight.w500,
//   //               ),
//   //             ),
//   //           ),
//   //         ],
//   //       ),
//   //
//   //       Padding(
//   //         padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
//   //         child: Row(children: []),
//   //       ),
//   //     ],
//   //   );
//   // }
// }
//
// // SizedBox(width: 4),
// // CustomChips(
// //   onTap:
// //       () => setState(() {
// //         // selectedSize = "S";
// //       }),
// //   label: Text(
// //     widget.product.size,
// //     style: TTextTheme.lightTextTheme.labelSmall?.copyWith(
// //       fontWeight: FontWeight.w500,
// //       // height: -0.8,
// //       // color: selectedSize == "S" ? Colors.white : Colors.black,
// //     ),
// //   ),
// //   backgroundColor: Colors.white,
// //   // selectedSize == "S" ? AppColors.brown : Colors.white,
// //   height: 32,
// // ),
// // CustomChips(
// //   onTap:
// //       () => setState(() {
// //         // selectedSize = "M";
// //       }),
// //   label: Text(
// //     "M",
// //     style: TTextTheme.lightTextTheme.labelSmall?.copyWith(
// //       fontWeight: FontWeight.w500,
// //       // height: -0.8,
// //       // color: selectedSize == "M" ? Colors.white : Colors.black,
// //     ),
// //   ),
// //   backgroundColor: Colors.white,
// //   height: 32,
// // ),
// // CustomChips(
// //   onTap:
// //       () => setState(() {
// //         // selectedSize = "L";
// //       }),
// //   label: Text(
// //     "L",
// //     style: TTextTheme.lightTextTheme.labelSmall?.copyWith(
// //       fontWeight: FontWeight.w500,
// //       // height: -0.8,
// //       // color: selectedSize == "L" ? Colors.white : Colors.black,
// //     ),
// //   ),
// //   backgroundColor: Colors.white,
// //   // selectedSize == "L" ? AppColors.brown : Colors.white,
// //   height: 32,
// // ),
// //
// // CustomChips(
// //   onTap:
// //       () => setState(() {
// //         // selectedSize = "XL";
// //       }),
// //   label: Text(
// //     "XL",
// //     style: TTextTheme.lightTextTheme.labelSmall?.copyWith(
// //       fontWeight: FontWeight.w500,
// //       // height: -0.8,
// //       // color: selectedSize == "XL" ? Colors.white : Colors.black,
// //     ),
// //   ),
// //   backgroundColor: Colors.white,
// //   // selectedSize == "XL" ? AppColors.brown : Colors.white,
// //   height: 32,
// // ),
// // // SizedBox(width: 8),
// // CustomChips(
// //   onTap:
// //       () => setState(() {
// //         // selectedSize = "XXL";
// //       }),
// //   label: Text(
// //     "XXL",
// //     style: TTextTheme.lightTextTheme.labelSmall?.copyWith(
// //       fontWeight: FontWeight.w500,
// //       // height: -0.9,
// //       // color: selectedSize == "XXL" ? Colors.white : Colors.black,
// //     ),
// //   ),
// //   backgroundColor: Colors.white,
// //   // selectedSize == "XXL" ? AppColors.brown : Colors.white,
// //   height: 32,
// // ),
// // // SizedBox(width: 14),
// // CustomChips(
// //   onTap:
// //       () => setState(() {
// //         // selectedSize = "XXXL";
// //       }),
// //   label: Text(
// //     "XXXL",
// //     style: TTextTheme.lightTextTheme.labelSmall?.copyWith(
// //       fontWeight: FontWeight.w500,
// //       // height: -0.9,
// //       // color: selectedSize == "XXXL" ? Colors.white : Colors.black,
// //     ),
// //   ),
// //   backgroundColor: Colors.white,
// //   // selectedSize == "XXXL" ? AppColors.brown : Colors.white,
// //   height: 32,
// // ),
