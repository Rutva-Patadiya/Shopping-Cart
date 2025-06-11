import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/product.dart';

//converts the raw firebase data into dart classes
class ProductModel {
  final DocumentReference categoryId;
  final String categoryName;
  final String imageUrl;
  final String name;
  final double price;
  final double rating;
  final String productDetails;
  final String productContext;
  List<String>? size;

  ProductModel({
    required this.categoryId,
    required this.categoryName,
    required this.imageUrl,
    required this.name,
    required this.price,
    required this.rating,
    required this.productDetails,
    required this.productContext,
    this.size,
  });

  //converts the raw firebase data into dart object
  factory ProductModel.fromFirestore(Map<String, dynamic> data) {
    return ProductModel(
      categoryId: data['category_id'] ?? '',
      categoryName: data['category_name'] ?? '',
      name: data['name'] ?? '',
      imageUrl: data['image'] ?? '',
      //handles price type int to double conversion
      price:
          (data['price'] is int)
              ? data['price'].toDouble()
              : data['price'] ?? 0.0,
      rating:
          (data['rating'] is int)
              ? data['rating'].toDouble()
              : data['rating'] ?? 0.0,

      productDetails: data['product_details'] ?? '',
      productContext: data['product_context'] ?? '',
      size: data['size'] != null ? List<String>.from(data['size']) : [],
    );
  }

  Product toEntity() {
    return Product(
      categoryId: categoryId,
      name: name,
      categoryName: categoryName,
      price: price,
      imageUrl: imageUrl,
      rating: rating,
      productDetails: productDetails,
      productContext: productContext,
      size: size,
    );
  }
}

//here it takes data ad map from firebase and then we convert it into dart obj

// final categoryRef = data['category_id'];
// final categoryDoc = categoryRef.get();
// final categoryName = categoryDoc.get('name');
