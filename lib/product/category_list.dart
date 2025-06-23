import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_cart/core/utils/theme/theme.dart';

import '../Constants.dart';
import '../product/bloc/product_bloc.dart';
import '../product/bloc/product_event.dart';
import '../product/bloc/product_state.dart';
import '../product/data/models/category_model.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    // BlocSelector listens only to part of the state to avoid unnecessary rebuilds
    return BlocSelector<CategoryBloc, CategoryState, Map<String, dynamic>>(
      selector: (state) {
        // Checks if state is CategoryLoadSuccess and returns categories
        if (state is CategoryLoadSuccess) {
          return {
            'categories': state.categories,
            'selectedCategoryId': state.categoryId,
          };
        }
        // Default empty list and null selection
        return {'categories': <CategoryModel>[], 'selectedCategoryId': null};
      },
      builder: (context, data) {
        final categories = data['categories'] as List<CategoryModel>;
        final selectedCategoryId =
            data['selectedCategoryId'] as DocumentReference?;
        // final isAllSelected = categoryId == null;
        return SizedBox(
          height: 72,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            itemCount: categories.length + 1,
            itemBuilder: (context, index) {
              // First item: "All" button
              if (index == 0) {
                return SizedBox(
                  width: 72,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          context.read<ProductBloc>().add(
                            ProductFilteredEvent('All', null),
                          );
                          context.read<CategoryBloc>().add(
                            CategorySelectedEvent(categoryId: null),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: AppColors.lightBrown,
                          ),
                          // duration: const Duration(milliseconds: 100),
                          child: Icon(
                            Icons.all_inclusive,
                            size: 28,
                            color: AppColors.brown,
                          ),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'All',
                        style: TextTheme.of(context).labelSmall?.copyWith(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                );
              }

              // Category Item Rendering
              final category = categories[index - 1];
              final categoryRef = FirebaseFirestore.instance
                  .collection(Constants.categoriesCollection)
                  .doc(category.id);

              // print("Selected ID: ${selectedCategoryId?.id}");
              print("category ref: ${categoryRef.id}");
              // final isSelected = == categoryRef.id;
              return SizedBox(
                width: 72,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        print("All id= ${selectedCategoryId?.id}");
                        print("category id= ${categoryRef.id}");
                        // print(isSelected);
                        context.read<ProductBloc>().add(
                          ProductFilteredEvent(category.name, categoryRef),
                        );

                        //It will change the color of the Selected Category
                        context.read<CategoryBloc>().add(
                          CategorySelectedEvent(categoryId: categoryRef),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: AppColors.lightBrown,
                        ),
                        // duration: const Duration(milliseconds: 100),
                        child: Image.network(
                          category.image,
                          height: 28,
                          color: AppColors.brown,
                        ),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      category.name,
                      style: TextTheme.of(context).labelSmall?.copyWith(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
