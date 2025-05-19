import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String name;
  final String category;
  final int price;
  final String imageUrl;

  // Future<String> get categoryName async {
  //   final categoryDoc = await category.get();
  //   return categoryDoc.get('name');
  // }

  const Product({
    required this.name,
    required this.category,
    required this.price,
    required this.imageUrl,
  });

  // Future<String> getCategoryName() async {
  //   final categoryDoc = await category.get();
  //   return categoryDoc.get('name') ?? 'Unknown';
  // }

  //handles only products should be added in cart
  @override
  List<Object?> get props => [name, category, price, imageUrl];
}
