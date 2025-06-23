import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:shopping_cart/product/data/models/category_model.dart';

import '../domain/entities/product.dart';

/// Abstract class for all category states
abstract class CategoryState extends Equatable {
  final List<CategoryModel> categories;
  final DocumentReference? categoryId;

  const CategoryState({required this.categories, required this.categoryId});

  CategoryLoadInProgress withLoading() {
    return CategoryLoadInProgress(
      categories: categories,
      categoryId: categoryId,
    );
  }

  @override
  List<Object?> get props => [categories];
}

/// Empty state for categories
class EmptyCategoryState extends CategoryState {
  const EmptyCategoryState({
    required super.categories,
    required super.categoryId,
  });
}

/// Loading state for categories
class CategoryLoadInProgress extends CategoryState {
  const CategoryLoadInProgress({
    required super.categories,
    required super.categoryId,
  });
}

/// Successful load state for categories
class CategoryLoadSuccess extends CategoryState {
  const CategoryLoadSuccess({required super.categories, super.categoryId});
}

class CategoryLoadFailure extends CategoryState {
  const CategoryLoadFailure({
    required super.categories,
    required super.categoryId,
  });
}

/// Equatable: When the state changes, Equatable compares whether the parameters are the same.
/// If they are the same, it avoids re-rendering
/// Passed the parameters in the initial state so that we can reuse it by using the super keyword
abstract class ProductState extends Equatable {
  final List<Product> allProducts;
  final List<Product> filteredProducts;
  final String? categoryName;
  final DocumentReference? categoryId;
  final String searchQuery;

  // final List<CategoryModel> categories; // Uncomment if categories needed

  const ProductState({
    required this.allProducts,
    required this.filteredProducts,
    this.categoryName,
    this.categoryId,
    required this.searchQuery,
    // required this.categories,
  });

  /// Helper to quickly convert current state to loading state
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

/// Initial empty product state
class EmptyProductState extends ProductState {
  const EmptyProductState({
    required super.allProducts,
    required super.filteredProducts,
    required super.searchQuery,
    // required super.categories,
  });
}

/// Emits when the product state is loading
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

/// Emits when products are loaded successfully
class ProductLoadSuccess extends ProductState {
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

/// Triggers when the product loading fails
class ProductLoadFailure extends ProductState {
  final String errorMessage;

  const ProductLoadFailure({
    required this.errorMessage,
    required super.allProducts,
    required super.filteredProducts,
    required super.searchQuery,
    // required super.categories,
  });

  @override
  List<Object?> get props => [
    allProducts,
    filteredProducts,
    categoryName,
    categoryId,
    searchQuery,
    errorMessage,
    // categories,
  ];
}

/// Abstract class for all product variant states
abstract class ProductVariantState extends Equatable {
  final Map<String, dynamic> variants;

  const ProductVariantState({required this.variants});

  /// Optional helper method to convert current state to loading state
  ProductVariantInProgress withLoading() {
    return ProductVariantInProgress(variants: variants);
  }

  @override
  List<Object?> get props => [variants];
}

/// Initial or empty state for product variants
class EmptyProductVariantState extends ProductVariantState {
  const EmptyProductVariantState({required super.variants});
}

/// Loading state for product variants
class ProductVariantInProgress extends ProductVariantState {
  const ProductVariantInProgress({required super.variants});
}

/// Successful load state for product variants
class ProductVariantsLoadSuccess extends ProductVariantState {
  const ProductVariantsLoadSuccess({required super.variants});
}

/// Failure state for product variants
class ProductVariantFailure extends ProductVariantState {
  final String message;

  const ProductVariantFailure({required this.message, required super.variants});

  @override
  List<Object?> get props => [variants, message];
}
