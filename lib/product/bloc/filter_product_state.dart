import 'package:equatable/equatable.dart';

import '../domain/entities/product.dart';

//Equatable: when the state changes Equatable compare that whether the parameters are same or not if they are same then don't re render it
abstract class ProductState extends Equatable {
  @override
  List<Object?> get props => [];
}

//emits when the state is loading
class ProductLoadInProgress extends ProductState {}

//emits when products are loaded successfully
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

//triggers when the product loading fails
class ProductLoadFailure extends ProductState {
  final String message;

  ProductLoadFailure(this.message);

  @override
  List<Object?> get props => [message];
}
