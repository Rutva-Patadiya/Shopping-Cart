import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_cart/core/utils/theme/theme.dart';
import 'package:shopping_cart/product/data/datasources/product_data_sources.dart';

import '../product/bloc/filter_product_bloc.dart';
import '../product/bloc/filter_product_event.dart';
import '../product/bloc/filter_product_state.dart';
import '../product/data/models/category_model.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ProductBloc, ProductState, Map<String, dynamic>>(
      selector: (state) {
        //if checks that state is ProductLoadSuccess and if categories is not empty
        if (state is ProductLoadSuccess && state.categories.isNotEmpty) {
          return {
            'categories': state.categories,
            'selectedCategoryId': state.categoryId,
          };
        }
        //if productloadsuccess and categories is empty
        return {'categories': <CategoryModel>[], 'selectedCategoryId': null};
      },
      builder: (context, data) {
        final categories = data['categories'] as List<CategoryModel>;
        final selectedCategoryId =
            data['selectedCategoryId'] as DocumentReference?;
        final isAllSelected = selectedCategoryId == null;

        return SizedBox(
          height: 80,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            itemCount: categories.length + 1,
            itemBuilder: (context, index) {
              if (index == 0) {
                return Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        context.read<ProductBloc>().add(
                          ProductFilteredEvent('All', null),
                        );
                      },
                      child: AnimatedContainer(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 14,
                        ),
                        margin: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color:
                              isAllSelected
                                  ? AppColors.brown
                                  : AppColors.lightBrown,
                        ),
                        duration: const Duration(milliseconds: 100),
                        child: Icon(
                          Icons.all_inclusive,
                          size: 28,
                          color: isAllSelected ? Colors.white : AppColors.brown,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      child: Text(
                        'All',
                        style: TextTheme.of(context).labelSmall?.copyWith(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color:
                              isAllSelected ? AppColors.brown : Colors.black87,
                        ),
                      ),
                    ),
                  ],
                );
              }

              final category = categories[index - 1];
              final categoryRef = FirebaseFirestore.instance
                  .collection(ProductDataSources.categoriesCollection)
                  .doc(category.id);
              final isSelected = selectedCategoryId?.id == categoryRef.id;

              return Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      context.read<ProductBloc>().add(
                        ProductFilteredEvent(category.name, categoryRef),
                      );
                    },
                    child: AnimatedContainer(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 14,
                      ),
                      margin: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color:
                            isSelected ? AppColors.brown : AppColors.lightBrown,
                      ),
                      duration: const Duration(milliseconds: 100),
                      child: Image.network(
                        category.image,
                        height: 28,
                        color: isSelected ? Colors.white : AppColors.brown,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: Text(
                      category.name,
                      style: TextTheme.of(context).labelSmall?.copyWith(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: isSelected ? AppColors.brown : Colors.black87,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:shopping_cart/product/bloc/filter_product_event.dart';
//
// import '../core/utils/theme/theme.dart';
// import 'bloc/filter_product_bloc.dart';
// import 'bloc/filter_product_state.dart';
// import 'data/datasources/product_data_sources.dart';
// import 'data/models/category_model.dart';
//
// class CategoryList extends StatefulWidget {
//   const CategoryList({super.key});
//
//   @override
//   State<CategoryList> createState() => _CategoryListState();
// }
//
// class _CategoryListState extends State<CategoryList> {
//   final ProductDataSources dataSource = ProductDataSources();
//   static const collectionName = 'categories';
//
//   @override
//   void initState() {
//     super.initState();
//     context.read<CategoryBloc>().add(CategoryLoadedEvent());
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<CategoryBloc, CategoryState>(
//       builder: (context, categoryState) {
//         return BlocBuilder<ProductBloc, ProductState>(
//           builder: (context, productState) {
//             List<CategoryModel> categories = [];
//             DocumentReference? selectedCategoryId;
//             bool isAllSelected = true;
//
//             if (productState is ProductLoadSuccess) {
//               selectedCategoryId = productState.categoryId;
//               //if the categoryid is null that means nothing is selected
//               isAllSelected = selectedCategoryId == null;
//             }
//
//             if (categoryState is CategoryLoadInProgress) {
//               return const Center(child: CircularProgressIndicator());
//             } else if (categoryState is CategoryLoadSuccess) {
//               categories = categoryState.categories;
//             } else if (categories.isEmpty) {
//               return const Text("No categories found");
//             }
//
//             return SizedBox(
//               height: 80,
//               child: ListView.builder(
//                 scrollDirection: Axis.horizontal,
//                 padding: const EdgeInsets.symmetric(horizontal: 12),
//                 itemCount: categories.length + 1,
//                 itemBuilder: (context, index) {
//                   if (index == 0) {
//                     // First item: "All"
//                     return Column(
//                       children: [
//                         GestureDetector(
//                           onTap: () {
//                             context.read<ProductBloc>().add(
//                               ProductFilteredEvent('All', null),
//                             );
//                           },
//                           child: AnimatedContainer(
//                             padding: const EdgeInsets.symmetric(
//                               horizontal: 14,
//                               vertical: 14,
//                             ),
//                             margin: const EdgeInsets.symmetric(horizontal: 12),
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(50),
//                               color:
//                                   isAllSelected
//                                       ? AppColors.brown
//                                       : AppColors.lightBrown,
//                             ),
//                             duration: const Duration(milliseconds: 100),
//                             child: Icon(
//                               Icons.all_inclusive,
//                               size: 28,
//                               color:
//                                   isAllSelected
//                                       ? Colors.white
//                                       : AppColors.brown,
//                             ),
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(vertical: 2),
//                           child: Text(
//                             'All',
//                             style: TextTheme.of(context).labelSmall?.copyWith(
//                               fontSize: 10,
//                               fontWeight: FontWeight.w600,
//                               color:
//                                   isAllSelected
//                                       ? AppColors.brown
//                                       : Colors.black87,
//                             ),
//                           ),
//                         ),
//                       ],
//                     );
//                   }
//
//                   // Regular categories
//                   final category = categories[index - 1];
//                   final categoryRef = FirebaseFirestore.instance
//                       .collection(collectionName)
//                       .doc(category.id);
//                   final isSelected = selectedCategoryId?.id == categoryRef.id;
//
//                   return Column(
//                     children: [
//                       GestureDetector(
//                         onTap: () {
//                           context.read<ProductBloc>().add(
//                             ProductFilteredEvent(category.name, categoryRef),
//                           );
//                         },
//                         child: AnimatedContainer(
//                           padding: const EdgeInsets.symmetric(
//                             horizontal: 14,
//                             vertical: 14,
//                           ),
//                           margin: const EdgeInsets.symmetric(horizontal: 12),
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(50),
//                             color:
//                                 isSelected
//                                     ? AppColors.brown
//                                     : AppColors.lightBrown,
//                           ),
//                           duration: const Duration(milliseconds: 100),
//                           child: Image.network(
//                             category.image,
//                             height: 28,
//                             color: isSelected ? Colors.white : AppColors.brown,
//                           ),
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(vertical: 2),
//                         child: Text(
//                           category.name,
//                           style: TextTheme.of(context).labelSmall?.copyWith(
//                             fontSize: 10,
//                             fontWeight: FontWeight.w600,
//                             color:
//                                 isSelected ? AppColors.brown : Colors.black87,
//                           ),
//                         ),
//                       ),
//                     ],
//                   );
//                 },
//               ),
//             );
//           },
//         );
//       },
//     );
//   }
// }
