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
    // return BlocSelector<CategoryBloc, CategoryState>(
    //   selector: (state) {
    //     if (state is CategoryLoadSuccess && state.categories.isNotEmpty) {}
    //   },
    // return BlocSelector<ProductBloc, ProductState, Map<String, dynamic>>(
    //     selector: (state) {
    //       //if checks that state is ProductLoadSuccess and if categories is not empty
    //       if (state is ProductLoadSuccess && state.categories.isNotEmpty) {
    //         return {
    //           'categories': state.categories,
    //           'selectedCategoryId': state.categoryId,
    //         };
    //       }
    //       //if productloadsuccess and categories is empty
    //       return {'categories': <CategoryModel>[], 'selectedCategoryId': null};
    //     },
    return BlocSelector<ProductBloc, ProductState, Map<String, dynamic>>(
      selector: (state) {
        //if checks that state is ProductLoadSuccess and if categories is not empty
        if (state is ProductLoadSuccess) {
          return {
            'categories': state.categoryName,
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
          height: 72,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            itemCount: categories.length + 1,
            itemBuilder: (context, index) {
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
                        },
                        child: AnimatedContainer(
                          padding: const EdgeInsets.all(12),
                          margin: const EdgeInsets.symmetric(horizontal: 8),
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
                            color:
                                isAllSelected ? Colors.white : AppColors.brown,
                          ),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'All',
                        style: TextTheme.of(context).labelSmall?.copyWith(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color:
                              isAllSelected ? AppColors.brown : Colors.black87,
                        ),
                      ),
                    ],
                  ),
                );
              }

              final category = categories[index - 1];
              final categoryRef = FirebaseFirestore.instance
                  .collection(Constants.categoriesCollection)
                  .doc(category.id);
              final isSelected = selectedCategoryId?.id == categoryRef.id;

              return SizedBox(
                width: 72,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        context.read<ProductBloc>().add(
                          ProductFilteredEvent(category.name, categoryRef),
                        );
                      },
                      child: AnimatedContainer(
                        padding: const EdgeInsets.all(12),
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color:
                              isSelected
                                  ? AppColors.brown
                                  : AppColors.lightBrown,
                        ),
                        duration: const Duration(milliseconds: 100),
                        child: Image.network(
                          category.image,
                          height: 28,
                          color: isSelected ? Colors.white : AppColors.brown,
                        ),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      category.name,
                      style: TextTheme.of(context).labelSmall?.copyWith(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: isSelected ? AppColors.brown : Colors.black87,
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
