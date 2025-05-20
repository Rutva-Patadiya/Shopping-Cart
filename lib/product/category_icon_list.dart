import 'package:flutter/material.dart';
import 'package:shopping_cart/product/data/datasources/product_data_sources.dart';
import 'package:shopping_cart/product/data/models/category_model.dart';

class CategoryIcon extends StatefulWidget {
  const CategoryIcon({super.key});

  @override
  State<CategoryIcon> createState() => _CategoryIconState();
}

class _CategoryIconState extends State<CategoryIcon> {
  late Future<List<CategoryModel>> _categoryFuture;
  final ProductDataSources dataSource = ProductDataSources(); // Create instance
  String selectedCategory = "All";

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
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }

        if (snapshot.hasError || !snapshot.hasData) {
          return const Text("Error fetching categories");
        }

        final categories = snapshot.data!;

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ...categories.map((category) {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 16,
                        ),
                        margin: EdgeInsets.only(left: 12, right: 12),
                        // height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.brown[100],
                        ),

                        child: Image.network(
                          category.image,
                          height: 28,
                          color: Colors.brown,
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ],
          ),
        );
      },
    );
  }
}

//   const CategoryIcon({super.key});
//
//   @override
//   State<StatefulWidget> createState() => CategoryIconState();
//
// }
// class CategoryIconState extends State<CategoryIcon>
// {
//   late Future<List<CategoryModel>> _categoryFuture;
//   final ProductDataSources dataSources = ProductDataSources();
//   @override
//   void initState() {
//     super.initState();
//     _categoryFuture = dataSources.fetchCategories();
//   }
//
//   @override
//   Widget build(BuildContext context)
//   {
//     FutureBuilder<List<CategoryIcon>>(
//         future: _categoryFuture,
//         builder: (context, snapshot)
//     {
//       if (snapshot.connectionState == ConnectionState.waiting) {
//         return const CircularProgressIndicator();
//       }
//
//       if (snapshot.hasError || !snapshot.hasData) {
//         return const Text("Error fetching categories");
//       }
//
//       final categories = snapshot.data!;
//
//
//
//       );
//     });
//   }
