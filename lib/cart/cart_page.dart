import 'package:flutter/material.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  static const route = '/cart';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Your Cart")),
      // body: BlocBuilder<AddToCartBloc, AddToCartState>(
      //   builder: (context, state) {
      //     if (AddToCartState is CartLoaded) {
      //       return ListView.builder(
      //         itemCount: cartItems.length,
      //         itemBuilder: (context, index) {
      //           final product = state.cartItems[index];
      //
      //           return ListTile(
      //             title: Text(product.name),
      //             leading:
      //                 product.imageUrl.endsWith('.svg')
      //                     ? SvgPicture.network(
      //                       product.imageUrl,
      //                       width: 40,
      //                       height: 40,
      //                       placeholderBuilder:
      //                           (context) => CircularProgressIndicator(),
      //                     )
      //                     : Image.network(product.imageUrl),
      //             subtitle: Text(product.category),
      //             trailing: Text(product.price),
      //           );
      //         },
      //       );
      //     }
      //   },
      // ),
    );
  }
}
