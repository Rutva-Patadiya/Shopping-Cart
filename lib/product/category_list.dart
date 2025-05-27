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
  late Future<List<CategoryModel>> _categoryFuture;
  final ProductDataSources dataSource = ProductDataSources(); // Create instance
  // String selectedCategory = "Clothing";
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
      builder: (context, state) {
        List<CategoryModel> categories = [];

        if (state is CategoryLoadInProgress) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is CategoryLoadSuccess) {
          categories = state.categories;
        } else if (categories.isEmpty) {
          return Text("No categories found");
        }

        return SizedBox(
          height: 80,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              return Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      final categoryReference = FirebaseFirestore.instance
                          .collection(collectionName)
                          .doc(category.id);
                      // selectedCategory = category.name;
                      context.read<ProductBloc>().add(
                        ProductFilteredEvent(category.name, categoryReference),
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                      margin: EdgeInsets.only(left: 12, right: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: AppColors.lightBrown,
                      ),

                      //displays image of categories
                      child: Image.network(
                        category.image,
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
