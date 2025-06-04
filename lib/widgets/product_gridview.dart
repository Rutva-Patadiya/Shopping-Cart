import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_cart/product/bloc/product_bloc.dart';
import 'package:shopping_cart/product/bloc/product_state.dart';
import 'package:shopping_cart/product/product_card.dart';

import '../product/domain/entities/product.dart';

//shows the gridview of products seperated widget

class ProductGridView extends StatelessWidget {
  const ProductGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text("abc"),

        Expanded(
          child: BlocBuilder<ProductBloc, ProductState>(
            builder: (context, state) {
              if (state is ProductLoadInProgress) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is ProductLoadFailure) {
                return Center(child: Text(state.errorMessage));
              }

              // Only use BlocSelector once state is loaded
              return BlocSelector<ProductBloc, ProductState, List<Product>>(
                //selector returns the current state
                selector: (state) {
                  if (state is ProductLoadSuccess) {
                    return state.filteredProducts;
                  }
                  return [];
                },

                //this is the portion which is going to modify
                builder: (context, products) {
                  //here products is the current state thrown by the selector
                  if (products.isEmpty) {
                    return const Center(child: Text('No products found.'));
                  }

                  return GridView.builder(
                    shrinkWrap: true,
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
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
