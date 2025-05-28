import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:shopping_cart/product/data/models/category_model.dart';

import '../domain/entities/product.dart';

// Equatable: when the state changes, Equatable compares whether the parameters are the same.
// If they are the same, it avoids re-rendering
abstract class ProductState extends Equatable {
  @override
  List<Object?> get props => [];
}

abstract class CategoryState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProductInitial extends ProductState {}

//emits when the state is loading
class ProductLoadInProgress extends ProductState {}

//emits when products are loaded successfully

class ProductLoadSuccess extends ProductState {
  final List<Product> allProducts;
  final List<Product> filteredProducts;
  final String? categoryName;
  final DocumentReference? categoryId;
  final String searchQuery;

  ProductLoadSuccess({
    required this.allProducts,
    required this.filteredProducts,
    this.categoryName,
    required this.categoryId,
    required this.searchQuery,
  });

  @override
  List<Object?> get props => [
    allProducts,
    filteredProducts,
    categoryId,
    categoryName,
    searchQuery,
  ];
}

//triggers when the product loading fails
class ProductLoadFailure extends ProductState {
  final String errorMessage;

  ProductLoadFailure(this.errorMessage);
}

class CategoryInitial extends CategoryState {}

//category list bloc
class CategoryLoadInProgress extends CategoryState {}

class CategoryLoadSuccess extends CategoryState {
  final List<CategoryModel> categories;

  CategoryLoadSuccess(this.categories);
}

class CategoryLoadFailure extends CategoryState {
  final String message;

  CategoryLoadFailure(this.message);
}
