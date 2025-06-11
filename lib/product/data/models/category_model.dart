import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  final String id;
  final String name;
  final String image;
  final List<String> size;

  CategoryModel({
    required this.id,
    required this.name,
    required this.image,
    required this.size,
  });

  factory CategoryModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return CategoryModel(
      id: doc.id,
      name: data['name'] ?? '',
      image: data['image'] ?? '',
      size: List<String>.from(
        data['size'] ?? [],
      ), // Parse the size list correctly
    );
  }
}
