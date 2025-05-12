import '../../domain/enitities/product.dart';

class ProductModel {
  final String name;
  final String category;
  final int price;
  final String imageUrl;

  ProductModel({
    required this.name,
    required this.category,
    required this.price,
    required this.imageUrl,
  });

  factory ProductModel.fromFirestore(Map<String, dynamic> data) {
    return ProductModel(
      name: data['Name'] ?? '',
      category: data['Category'] ?? '',
      price: data['Price'] ?? 0,
      imageUrl: data['Image'] ?? '',
    );
  }

  Product toEntity() {
    return Product(
      name: name,
      category: category,
      price: price,
      imageUrl: imageUrl,
    );
  }
}
