import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_cart/product/bloc/filter_product_bloc.dart';
import 'package:shopping_cart/product/bloc/filter_product_state.dart';
import 'package:shopping_cart/product/product_card.dart';

import '../product/domain/entities/product.dart';

//shows the gridview of products seperated widget
class ProductGridView extends StatelessWidget {
  const ProductGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        if (state is ProductLoadInProgress) {
          return const Center(child: CircularProgressIndicator());
        }
        return BlocSelector<ProductBloc, ProductState, List<Product>>(
          selector: (state) {
            if (state is ProductLoadSuccess) {
              return state.filteredProducts;
            }

            return [];
          },
          builder: (context, products) {
            return Column(
              children: [
                Text("harsh"),
                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.all(12),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 16,
                          childAspectRatio: 0.7,
                        ),
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      return ProductCard(product: products[index]);
                    },
                  ),
                ),
              ],
            );
          },
        );
        // return BlocBuilder<ProductBloc, ProductState>(
        //   builder: (context, state) {
        //     if (state is ProductLoadInProgress) {
        //       return const Center(child: CircularProgressIndicator());
        //     } else if (state is ProductLoadSuccess) {
        //       final products = state.filteredProducts;
        //       return Column(
        //         children: [
        //           Text("harsh"),
        //           Expanded(
        //             child: GridView.builder(
        //               padding: const EdgeInsets.all(12),
        //               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        //                 crossAxisCount: 2,
        //                 mainAxisSpacing: 16,
        //                 crossAxisSpacing: 16,
        //                 childAspectRatio: 0.7,
        //               ),
        //               itemCount: products.length,
        //               itemBuilder: (context, index) {
        //                 return ProductCard(product: products[index]);
        //               },
        //             ),
        //           ),
        //         ],
        //       );
        //     } else if (state is ProductLoadFailure) {
        //       return Center(child: Text(state.errorMessage));
        //     }
        //     return const SizedBox.shrink();
        //   },
        // );
      },
    );
  }
}
