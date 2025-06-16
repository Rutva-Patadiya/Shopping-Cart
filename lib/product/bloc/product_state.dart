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

//super class for all Color states
abstract class ColorState extends Equatable {
  @override
  List<Object?> get props => [];
}

//super class for all Weight states
abstract class WeightState extends Equatable {
  @override
  List<Object?> get props => [];
}

//emits when the state is loading
class ProductLoadInProgress extends ProductState {}

//emits when products are loaded successfully
class ProductLoadSuccess extends ProductState {
  final List<Product> allProducts;
  final List<Product> filteredProducts;
  final String? categoryName;
  final DocumentReference? categoryId;
  final String searchQuery;
  final List<CategoryModel> categories;

  ProductLoadSuccess({
    required this.allProducts,
    required this.filteredProducts,
    this.categoryName,
    required this.categoryId,
    required this.searchQuery,
    required this.categories,
  });

  @override
  List<Object?> get props => [
    allProducts,
    filteredProducts,
    categoryId,
    categoryName,
    searchQuery,
    categories,
  ];
}

//triggers when the product loading fails
class ProductLoadFailure extends ProductState {
  final String errorMessage;

  ProductLoadFailure(this.errorMessage);
}

class CategoryLoadFailure extends ProductState {
  final String message;

  CategoryLoadFailure(this.message);
}

//Triggers when the product size is loaded
class ProductSizeLoadSuccess extends ProductState {
  final List<String> productSize;
  final String sizeList;

  ProductSizeLoadSuccess({required this.productSize, required this.sizeList});
}

//triggers when the productColor is loading
class ProductColorInProgress extends ColorState {}

//triggers when productColor is loaded
class ProductColorLoadSuccess extends ColorState {
  final List<String> colorList;
  final String productColor; // Add the colorList parameter

  ProductColorLoadSuccess({
    required this.productColor,
    required this.colorList,
  });
}

//triggers when the productColor loading fails
class ProductColorLoadFailure extends ColorState {
  final String errorMessage;

  ProductColorLoadFailure(this.errorMessage);
}

//triggers when the productWeight is loading
// class ProductWeightInProgress extends ColorState {}
//
// //triggers when productWeight is loaded
// class ProductWeightLoadSuccess extends ColorState {
//   final List<String> weightList;
//
//   ProductWeightLoadSuccess({required this.weightList});
// }
