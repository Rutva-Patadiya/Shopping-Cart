import '../../domain/entities/product.dart';

//converts the raw firebase data into dart classes
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

  //here it takes data ad map from firebase and then we convert it into dart obj
  factory ProductModel.fromFirestore(Map<String, dynamic> data) {
    return ProductModel(
      name: data['name'] ?? '',
      category: data['category'] ?? '',
      price: data['price'] ?? 0,
      imageUrl: data['image'] ?? '',
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
