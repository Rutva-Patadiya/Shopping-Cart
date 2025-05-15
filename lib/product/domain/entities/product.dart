import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String name;
  final String category;
  final int price;
  final String imageUrl;

  const Product({
    required this.name,
    required this.category,
    required this.price,
    required this.imageUrl,
  });

  @override
  List<Object?> get props => [name];
}
