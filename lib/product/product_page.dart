import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_cart/product/product_list.dart';

import '../core/utils/theme/text_theme.dart';
import '../core/utils/theme/theme.dart';
import '../signup/signup_page.dart';
import 'bloc/filter_product_bloc.dart';
import 'bloc/filter_product_event.dart';

class ProductList extends StatelessWidget {
  const ProductList({super.key});

  static const route = '/product';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 32),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: CustomTextField(
              label: null,
              keyboardType: TextInputType.name,
              hint: "Enter Product",
              hintStyle: TTextTheme.lightTextTheme.titleSmall,
              obscureText: false,
              controller: SearchController(),
              prefixIcon: Icons.search,
              suffixIcon: null,
              validator: null,
            ),
          ),

          SizedBox(height: 16),

          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                CustomButton(
                  name: "All",
                  onPressed: () {
                    context.read<ProductFilterBloc>().add(
                      FilterProducts("All"),
                    );
                  },
                ),
                CustomButton(
                  name: "Electronic",
                  onPressed: () {
                    context.read<ProductFilterBloc>().add(
                      FilterProducts("Electronic"),
                    );
                  },
                ),
                CustomButton(
                  name: "Clothing",
                  onPressed: () {
                    context.read<ProductFilterBloc>().add(
                      FilterProducts("Clothing"),
                    );
                  },
                ),
                CustomButton(
                  name: "Grocery",
                  onPressed: () {
                    context.read<ProductFilterBloc>().add(
                      FilterProducts("Grocery"),
                    );
                  },
                ),
              ],
            ),
          ),

          // Expanded(
          //   child: BlocBuilder<ProductFilterBloc, ProductFilterState>(
          //     builder: (context, state) {
          //       if (state is ProductFilterLoading) {
          //         return const Center(child: CircularProgressIndicator());
          //       } else if (state is ProductFilterLoaded) {
          //         final products = state.filteredProducts;
          //
          //         return ListView.builder(
          //           itemCount: products.length,
          //           itemBuilder: (context, index) {
          //             return ProductCard(product: products[index]);
          //           },
          //         );
          //       } else if (state is ProductFilterError) {
          //         return Center(child: Text(state.message));
          //       }
          //       return const SizedBox.shrink();
          //     },
          //   ),
          // ),
          Expanded(
            child: FutureBuilder<List<Product>>(
              future: fetchProducts(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                final products = snapshot.data ?? [];

                return ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    return ProductCard(product: products[index]);
                  },
                );
              },
            ),
            // Product list
            // Expanded(
            //   child: ListView.builder(
            //     itemCount: allProducts.length,
            //     itemBuilder: (context, index) {
            //       return ProductCard(product: allProducts[index]);
            //     },
            //   ),
            // ),
          ),
          // AddProductPage(),
        ],
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final String name;
  final VoidCallback onPressed;

  const CustomButton({super.key, required this.name, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.grey,
          // Override background color
          foregroundColor: Colors.black,
          // Override text/icon color
          minimumSize: Size(30, 40),
          // Override size
          textStyle: TextStyle(
            fontWeight: FontWeight.normal,
            letterSpacing: 0.5,
          ),
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        ),
        onPressed: () {
          onPressed;
        },
        child: Text(name),
      ),
    );
  }
}
