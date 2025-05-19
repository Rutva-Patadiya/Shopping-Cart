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

  ProductLoadSuccess({required this.allProducts, required this.filteredProducts});

  @override
  List<Object?> get props => [allProducts, filteredProducts];
}

class ProductLoadFailure extends ProductState {
  final String message;

  ProductLoadFailure(this.message);

  @override
  List<Object?> get props => [message];
}

//
// class CategoryState extends ProductState {
//   final String selectedCategoryId;
//
//    CategoryState({required this.selectedCategoryId});
//
//   @override
//   List<Object?> get props => [selectedCategoryId];
// }