import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final DocumentReference categoryId;
  final String categoryName;
  final String imageUrl;
  final String name;
  final int price;

  const Product({
    required this.categoryId,
    required this.categoryName,
    required this.price,
    required this.imageUrl,
    required this.name,
  });

  //handles only products should be added in cart
  @override
  List<Object?> get props => [name, categoryId, price, imageUrl, categoryName];
}

// Future<String> get categoryName async {
//   final categoryDoc = await category.get();
//   return categoryDoc.get('name');
// }
// Future<String> getCategoryName() async {
//   final categoryDoc = await category.get();
//   return categoryDoc.get('name') ?? 'Unknown';
// }
