import 'package:cloud_firestore/cloud_firestore.dart';

class ProductColorModel {
  final List<String> colors;
  final String id;

  ProductColorModel({required this.id, required this.colors});

  factory ProductColorModel.fromFireStore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ProductColorModel(
      colors: List<String>.from(data['color']),
      id: doc.id,
    );
  }
}
