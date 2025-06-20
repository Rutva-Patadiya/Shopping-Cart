import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:shopping_cart/product/data/models/category_model.dart';

import '../domain/entities/product.dart';

abstract class CategoryState extends Equatable {
  final List<CategoryModel> categories;

  const CategoryState({required this.categories});
}

class CategoryLoadInProgress extends CategoryState {
  const CategoryLoadInProgress({required super.categories});

  @override
  List<Object?> get props => [categories];
}

class CategoryLoadSuccess extends CategoryState {
  const CategoryLoadSuccess({required super.categories});

  @override
  List<Object?> get props => [categories];
}

// Equatable: when the state changes, Equatable compares whether the parameters are the same.
// If they are the same, it avoids re-rendering
/// Passed the parameters in the initial state so that we can reuse it by using the super keyword
abstract class ProductState extends Equatable {
  final List<Product> allProducts;
  final List<Product> filteredProducts;
  final String? categoryName;
  final DocumentReference? categoryId;
  final String searchQuery;

  const ProductState({
    required this.allProducts,
    required this.filteredProducts,
    this.categoryName,
    this.categoryId,
    required this.searchQuery,
    // required this.categories,
  });

  ProductLoadInProgress withLoading() {
    return ProductLoadInProgress(
      allProducts: allProducts,
      filteredProducts: filteredProducts,
      categoryName: categoryName,
      categoryId: categoryId,
      searchQuery: searchQuery,
      // categories: categories,
    );
  }

  @override
  List<Object?> get props => [
    allProducts,
    filteredProducts,
    categoryName,
    categoryId,
    searchQuery,
    // categories,
  ];
}

class EmptyProductState extends ProductState {
  const EmptyProductState({
    required super.allProducts,
    required super.filteredProducts,
    required super.searchQuery,
    // required super.categories,
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
    // required super.categories,
  });
}

//emits when products are loaded successfully
class ProductLoadSuccess extends ProductState {
  @override
  const ProductLoadSuccess({
    required super.allProducts,
    required super.filteredProducts,
    super.categoryName,
    required super.categoryId,
    required super.searchQuery,
    // required super.categories,
  });

  @override
  List<Object?> get props => [
    allProducts,
    filteredProducts,
    categoryId,
    categoryName,
    searchQuery,
    // categories,
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
    // required super.categories,
  });
}

/// Abstract class for all variant states
abstract class ProductVariantState extends Equatable {
  final Map<String, dynamic> variants;

  const ProductVariantState({required this.variants});

  // Optional helper method to convert current state to loading state
  ProductVariantInProgress withLoading() {
    return ProductVariantInProgress(variants: variants);
  }

  @override
  List<Object?> get props => [variants];
}

/// Initial or empty state
class EmptyProductVariantState extends ProductVariantState {
  const EmptyProductVariantState({required super.variants});
}

/// Loading state
class ProductVariantInProgress extends ProductVariantState {
  const ProductVariantInProgress({required super.variants});
}

/// Successful load state
class ProductVariantsLoadSuccess extends ProductVariantState {
  const ProductVariantsLoadSuccess({required super.variants});
}

/// Failure state
class ProductVariantFailure extends ProductVariantState {
  final String message;

  const ProductVariantFailure({required this.message, required super.variants});

  @override
  List<Object?> get props => [variants, message];
}
