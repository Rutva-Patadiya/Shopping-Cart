import 'package:equatable/equatable.dart';

import '../domain/entities/product.dart';

//Equatable: when the state changes Equatable compare that whether the parameters are same or not if they are same then dont re render it
abstract class ProductState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final List<Product> allProducts;
  final List<Product> filteredProducts;

  ProductLoaded({required this.allProducts, required this.filteredProducts});

  @override
  List<Object?> get props => [allProducts, filteredProducts];
}

class ProductError extends ProductState {
  final String message;

  ProductError(this.message);

  @override
  List<Object?> get props => [message];
}
