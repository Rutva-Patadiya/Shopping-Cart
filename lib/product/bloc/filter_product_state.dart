// abstract class FilterProduct {}
//
// class ProductLoading extends FilterProduct {}
//
// class ProductLoaded extends FilterProduct {}
// product_filter_state.dart

import '../product_list.dart';

abstract class ProductFilterState {}

class ProductFilterInitial extends ProductFilterState {}

class ProductFilterLoading extends ProductFilterState {}

class ProductFilterLoaded extends ProductFilterState {
  final List<Product> filteredProducts;

  ProductFilterLoaded(this.filteredProducts);
}

class ProductFilterError extends ProductFilterState {
  final String message;

  ProductFilterError(this.message);
}
