// shopping_cart/product/data/models/product_size_model.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductSizeModel {
  final String id;
  final List<String> sizes; // This will hold the list of strings

  ProductSizeModel({required this.id, required this.sizes});

  factory ProductSizeModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ProductSizeModel(
      id: doc.id,
      sizes: List<String>.from(
        data['size'] ?? [],
      ), // IMPORTANT: Use the actual field name for your sizes list
    );
  }
}
