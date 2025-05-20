import 'package:equatable/equatable.dart';

import '../domain/entities/product.dart';

//Equatable: when the state changes Equatable compare that whether the parameters are same or not if they are same then dont re render it
abstract class ProductState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProductLoadInProgress extends ProductState {}

class ProductLoadSuccess extends ProductState {
  final List<Product> allProducts;
  final List<Product> filteredProducts;
  final String selectedCategory;
  final String searchQuery;

  ProductLoadSuccess({
    required this.allProducts,
    required this.filteredProducts,
    required this.selectedCategory,
    required this.searchQuery,
  });

  @override
  List<Object?> get props => [allProducts, filteredProducts, selectedCategory];
}

class ProductLoadFailure extends ProductState {
  final String message;

  ProductLoadFailure(this.message);

  @override
  List<Object?> get props => [message];
}
