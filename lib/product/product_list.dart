import 'package:flutter/material.dart';
import 'package:shopping_cart/core/utils/theme/theme.dart';

class Product {
  final String name;
  final String category;
  final double price;
  final String imageUrl;

  Product({
    required this.name,
    required this.category,
    required this.price,
    required this.imageUrl,
  });
}

List<Product> allProducts = [
  Product(
    name: 'Apple',
    category: 'Grocery',
    price: 105,
    imageUrl: 'asset/images/apple.png',
  ),
  Product(
    name: 'T-Shirt',
    category: 'Clothing',
    price: 999,
    imageUrl: 'asset/images/tshirt.png',
  ),
  Product(
    name: 'Headphones',
    category: 'Electronic',
    price: 25.0,
    imageUrl: 'asset/images/headphones.png',
  ),
];

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({required this.product, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.creamColor,
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: Image.asset(product.imageUrl, width: 40, height: 40),
        title: Text(product.name),
        subtitle: Text('\$${product.price}'),
        trailing: Text(product.category),
      ),
    );
  }
}
