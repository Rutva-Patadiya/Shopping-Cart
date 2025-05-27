import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_cart/product/bloc/filter_product_event.dart';

import '../core/utils/theme/theme.dart';
import 'bloc/filter_product_bloc.dart';
import 'bloc/filter_product_state.dart';
import 'data/datasources/product_data_sources.dart';
import 'data/models/category_model.dart';

//shows the category list on home page
class CategoryList extends StatefulWidget {
  const CategoryList({super.key});

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  final ProductDataSources dataSource = ProductDataSources(); // Create instance
  static const collectionName = 'categories';

  @override
  void initState() {
    super.initState();
    //loads the category list AT initial level
    context.read<CategoryBloc>().add(CategoryLoadedEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, categoryState) {
        List<CategoryModel> categories = [];

        if (categoryState is CategoryLoadInProgress) {
          return const Center(child: CircularProgressIndicator());
        } else if (categoryState is CategoryLoadSuccess) {
          categories = categoryState.categories;
        } else if (categories.isEmpty) {
          return const Text("No categories found");
        }

        return SizedBox(
          height: 80,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      final categoryReference = FirebaseFirestore.instance
                          .collection(collectionName)
                          .doc(categories[index].id);

                      context.read<ProductBloc>().add(
                        ProductFilteredEvent(
                          categories[index].name,
                          categoryReference,
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                      margin: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: AppColors.lightBrown,
                      ),
                      child: Image.network(
                        categories[index].image,
                        height: 28,
                        color: AppColors.brown,
                      ),
                    ),
                  ),
                  Text(
                    categories[index].name,
                    style: TextTheme.of(
                      context,
                    ).labelSmall?.copyWith(fontWeight: FontWeight.w500),
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
