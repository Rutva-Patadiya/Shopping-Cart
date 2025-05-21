import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_cart/product/bloc/filter_product_event.dart';
import 'package:shopping_cart/product/data/datasources/product_data_sources.dart';
import 'package:shopping_cart/product/data/models/category_model.dart';

import '../core/utils/theme/theme.dart';
import 'bloc/filter_product_bloc.dart';

class CategoryList extends StatefulWidget {
  const CategoryList({super.key});

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  late Future<List<CategoryModel>> _categoryFuture;
  final ProductDataSources dataSource = ProductDataSources(); // Create instance
  // String selectedCategory = "Clothing";

  @override
  void initState() {
    super.initState();
    _categoryFuture = dataSource.fetchCategories(); // Call your method
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<CategoryModel>>(
      future: _categoryFuture,
      builder: (context, snapshot) {
        // if (snapshot.connectionState == ConnectionState.waiting) {
        //   return const CircularProgressIndicator();
        // }

        if (snapshot.hasError || !snapshot.hasData) {
          return const Text("Error fetching categories");
        }

        final categories = snapshot.data!;
        //used listview
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
                      // selectedCategory = category.name;
                      context.read<ProductBloc>().add(
                        ProductFilteredEvent(category.name),
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

                  Text(categories[index].name),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
