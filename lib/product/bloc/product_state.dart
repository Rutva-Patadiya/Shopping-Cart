import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:shopping_cart/product/data/models/category_model.dart';

import '../domain/entities/product.dart';

// Equatable: when the state changes, Equatable compares whether the parameters are the same.
// If they are the same, it avoids re-rendering
abstract class ProductState extends Equatable {
  final List<Product> allProducts;
  final List<Product> filteredProducts;
  final String? categoryName;
  final DocumentReference? categoryId;
  final String searchQuery;
  final List<CategoryModel> categories;

  const ProductState({
    required this.allProducts,
    required this.filteredProducts,
    this.categoryName,
    this.categoryId,
    required this.searchQuery,
    required this.categories,
  });

  ProductLoadInProgress withLoading() {
    return ProductLoadInProgress(
      allProducts: allProducts,
      filteredProducts: filteredProducts,
      categoryName: categoryName,
      categoryId: categoryId,
      searchQuery: searchQuery,
      categories: categories,
    );
    // return ProductLoadInProgress();
  }

  @override
  List<Object?> get props => [
    allProducts,
    filteredProducts,
    categoryName,
    categoryId,
    searchQuery,
    categories,
  ];
}

class EmptyProductState extends ProductState {
  const EmptyProductState({
    required super.allProducts,
    required super.filteredProducts,
    required super.searchQuery,
    required super.categories,
  });
}

//emits when the state is loading
class ProductLoadInProgress extends ProductState {
  const ProductLoadInProgress({
    required super.allProducts,
    required super.filteredProducts,
    super.categoryName,
    super.categoryId,
    required super.searchQuery,
    required super.categories,
  });
}

//emits when products are loaded successfully
class ProductLoadSuccess extends ProductState {
  final List<Product> allProducts;
  final List<Product> filteredProducts;
  final String? categoryName;
  final DocumentReference? categoryId;
  final String searchQuery;
  final List<CategoryModel> categories;

  // remaining to solve the error
  @override
  ProductLoadSuccess({
    required this.allProducts,
    required this.filteredProducts,
    this.categoryName,
    required this.categoryId,
    required this.searchQuery,
    required this.categories,
  }) : super(allProducts: [], filteredProducts: null);

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

  const ProductLoadFailure({
    required this.errorMessage,
    required super.allProducts,
    required super.filteredProducts,
    required super.searchQuery,
    required super.categories,
  });
}

abstract class ProductVariantState {}

class ProductVariantInProgress extends ProductVariantState {}

class ProductVariantsLoadSuccess extends ProductVariantState {
  final Map<String, dynamic> variants;

  ProductVariantsLoadSuccess(this.variants);
}

class ProductVariantFailure extends ProductVariantState {
  final String message;

  ProductVariantFailure(this.message);
}
