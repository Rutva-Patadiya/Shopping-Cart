// shopping_cart/product/data/models/product_size_model.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductSizeModel {
  final String productId;
  final List<String> sizes; // This will hold the list of strings
  final String name;

  ProductSizeModel({
    required this.name,
    required this.productId,
    required this.sizes,
  });

  factory ProductSizeModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ProductSizeModel(
      productId: doc.id,
      sizes: List<String>.from(data['size'] ?? []),
      name: data['name'],
    );
  }
}
