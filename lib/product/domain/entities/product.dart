import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final DocumentReference categoryId;
  final String categoryName;
  final String imageUrl;
  final String name;
  final double price;
  final double? rating;
  final String productDetails;
  final String productContext;

  Product({
    required this.categoryId,
    required this.categoryName,
    required this.price,
    required this.imageUrl,
    required this.name,
    required this.rating,
    required this.productDetails,
    required this.productContext,
  });

  //handles only products should be added in cart
  List<Object?> get props => [
    name,
    categoryId,
    price,
    imageUrl,
    categoryName,
    productDetails,
    productContext,
  ];
}
