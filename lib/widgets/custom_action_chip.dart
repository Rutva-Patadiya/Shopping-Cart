import 'package:flutter/material.dart';

import '../core/utils/theme/text_theme.dart';
import '../product/data/datasources/product_data_sources.dart';
import '../product/data/models/category_model.dart';

class CategoryChips extends StatelessWidget {
  final String selectedCategory;
  final Function(String categoryId) onCategoryChanged;

  const CategoryChips({
    super.key,
    required this.selectedCategory,
    required this.onCategoryChanged,
  });

  @override
  Widget build(BuildContext context) {
    final ProductDataSources dataSource = ProductDataSources();

    return FutureBuilder<List<CategoryModel>>(
      future: dataSource.fetchCategories(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }

        if (snapshot.hasError || !snapshot.hasData) {
          return const Text("Error fetching categories");
        }

        final categories = snapshot.data!;

        return Wrap(
          spacing: 8.0,
          children: [
            ActionChip(
              label: Text(
                "All",
                style: TTextTheme.lightTextTheme.labelLarge?.copyWith(
                  color:
                      selectedCategory == "All" ? Colors.white : Colors.black,
                  fontWeight: FontWeight.w400,
                ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              backgroundColor:
                  selectedCategory == "All" ? Colors.brown : Colors.white,
              onPressed: () {
                onCategoryChanged("All");
              },
            ),
            ...categories.map((category) {
              return ActionChip(
                label: Text(
                  category.name,
                  style: TTextTheme.lightTextTheme.labelLarge?.copyWith(
                    color:
                        selectedCategory == category.name
                            ? Colors.white
                            : Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                backgroundColor:
                    selectedCategory == category.name
                        ? Colors.brown
                        : Colors.white,
                onPressed: () {
                  onCategoryChanged(category.name);
                },
              );
            }),
          ],
        );
      },
    );
  }
}

// class CategoryChips extends StatefulWidget {
//   final Function(String categoryId) onCategoryChanged;
//
//   const CategoryChips({super.key, required this.onCategoryChanged});
//
//   @override
//   State<CategoryChips> createState() => _CategoryChipsState();
// }
//
// class CategoryChips extends StatelessWidget {
//   late Future<List<CategoryModel>> _categoryFuture;
//   final ProductDataSources dataSource = ProductDataSources(); // Create instance
//   // String selectedCategory = "All";
//
//   @override
//   void initState() {
//     super.initState();
//     _categoryFuture = dataSource.fetchCategories(); // Call your method
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<List<CategoryModel>>(
//       future: _categoryFuture,
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const CircularProgressIndicator();
//         }
//
//         if (snapshot.hasError || !snapshot.hasData) {
//           return const Text("Error fetching categories");
//         }
//
//         final categories = snapshot.data!;
//
//         return Wrap(
//           spacing: 8.0,
//           children: [
//             ActionChip(
//               label: Text(
//                 "All",
//                 style: TTextTheme.lightTextTheme.labelLarge?.copyWith(
//                   color:
//                       selectedCategory == "All" ? Colors.white : Colors.black,
//                   fontWeight: FontWeight.w400,
//                 ),
//               ),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(50),
//               ),
//               backgroundColor:
//                   selectedCategory == "All" ? Colors.brown : Colors.white,
//               onPressed: () {
//                 // context.read().add(ProductFilteredEvent("All"));
//                 setState(() {
//                   selectedCategory = "All";
//                 });
//                 widget.onCategoryChanged("All");
//               },
//             ),
//
//             ...categories.map((category) {
//               return ActionChip(
//                 label: Text(
//                   category.name,
//                   style: TTextTheme.lightTextTheme.labelLarge?.copyWith(
//                     color:
//                         selectedCategory == category.name
//                             ? Colors.white
//                             : Colors.black,
//                     fontWeight: FontWeight.w400,
//                   ),
//                 ),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(50),
//                 ),
//                 backgroundColor:
//                     selectedCategory == category.name
//                         ? Colors.brown
//                         : Colors.white,
//                 onPressed: () {
//                   // context.read().add(ProductFilteredEvent(category.name));
//                   setState(() {
//                     selectedCategory = category.name;
//                   });
//
//                   widget.onCategoryChanged(category.name);
//                 },
//               );
//             }),
//           ],
//         );
//       },
//     );
//   }
// }
