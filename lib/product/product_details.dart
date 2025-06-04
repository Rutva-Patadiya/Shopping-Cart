import 'package:flutter/material.dart';
import 'package:shopping_cart/product/domain/entities/product.dart';

class ProductDetailsPage extends StatelessWidget {
  static const route = "product_details";

  final Product product;

  const ProductDetailsPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Expanded(child: Container())));
  }
}
