// TODO Implement this library.import 'package:flutter/material.dart';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shopping_cart/cart/bloc/add_to_cart_bloc.dart';
import 'package:shopping_cart/core/utils/theme/theme.dart';

import '../core/utils/theme/text_theme.dart';
import 'bloc/add_to_cart_event.dart';
import 'bloc/add_to_cart_state.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  static const route = '/cart';

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  int itemCount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Your Cart",
          style: TTextTheme.lightTextTheme.headlineLarge?.copyWith(
            color: Colors.white,
          ),
        ),
        backgroundColor: AppColors.brown,
      ),
      body: BlocBuilder<AddToCartBloc, AddToCartState>(
        builder: (context, state) {
          log("State received: $state");
          if (state is CartLoaded) {
            final cartItems = state.cartItems.entries.toList();

            return ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final entry = cartItems[index];
                final product = entry.key;
                final quantity = entry.value;

                return ListTile(
                  title: Text(product.name),
                  leading:
                      product.imageUrl.endsWith('.svg')
                          ? SvgPicture.network(
                            product.imageUrl,
                            width: 40,
                            height: 40,
                            placeholderBuilder:
                                (context) => CircularProgressIndicator(),
                          )
                          : Image.network(product.imageUrl),
                  // subtitle: Text(product.category),
                  trailing: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2),
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2),
                            color: AppColors.green,
                          ),
                          width: 74,
                          height: 28,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                ),
                                child: InkWell(
                                  onTap: () {
                                    context.read<AddToCartBloc>().add(
                                      RemoveFromCartEvent(product),
                                    );
                                  },

                                  child: Icon(
                                    Icons.remove,
                                    size: 14,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 22,
                                child: Center(
                                  child: Text(
                                    '$quantity',
                                    style: TextTheme.of(context).labelMedium
                                        ?.copyWith(color: Colors.black54),
                                  ),
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                ),
                                child: InkWell(
                                  onTap: () {
                                    context.read<AddToCartBloc>().add(
                                      AddToCartEvent(product),
                                    );
                                  },
                                  child: Icon(
                                    Icons.add,
                                    size: 14,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          "₹${product.price * quantity}",
                          style: TextTheme.of(
                            context,
                          ).labelMedium?.copyWith(color: Colors.black87),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (state is CartError) {
            return Center(child: Text(state.message));
          } else {
            return Center(
              child: Text(
                "Your cart is Empty.",
                style: TextTheme.of(
                  context,
                ).headlineLarge?.copyWith(fontWeight: FontWeight.w400),
              ),
            );
          }
        },
      ),
    );
  }
}
