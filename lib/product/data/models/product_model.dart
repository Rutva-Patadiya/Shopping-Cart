import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/product.dart';

//converts the raw firebase data into dart classes
class ProductModel {
  final DocumentReference categoryId;
  final String categoryName;
  final String imageUrl;
  final String name;
  final double price;

  ProductModel({
    required this.categoryId,
    required this.categoryName,
    required this.imageUrl,
    required this.name,
    required this.price,
  });

  factory ProductModel.fromFirestore(Map<String, dynamic> data) {
    // print("Loaded product: ${data['name']}  ");
    // print("Loaded product: ${data['price']}  ");
    // print("Loaded product: ${data['image']}  ");
    // print("Loaded product: ${data['category_id'].path} ");

    return ProductModel(
      categoryId: data['category_id'],
      categoryName: data['category_name'] ?? '',
      name: data['name'] ?? '',
      imageUrl: data['image'] ?? '',
      price: data['price'] ?? 0.0,
    );
  }

  Product toEntity() {
    return Product(
      categoryId: categoryId,
      name: name,
      categoryName: categoryName,
      price: price,
      imageUrl: imageUrl,
    );
  }
}

//here it takes data ad map from firebase and then we convert it into dart obj

// final categoryRef = data['category_id'];
// final categoryDoc = categoryRef.get();
// final categoryName = categoryDoc.get('name');
