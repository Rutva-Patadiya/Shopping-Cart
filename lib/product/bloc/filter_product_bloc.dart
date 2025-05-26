import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_cart/product/domain/repositories/product_repositories.dart';

import '../domain/entities/product.dart';
import 'filter_product_event.dart';
import 'filter_product_state.dart';

//The bloc class is for managing the product related operation
class ProductBloc extends Bloc<FilterProductEvent, ProductState> {
  final ProductRepository repository;

  ProductBloc(this.repository) : super(ProductLoadInProgress()) {
    //Initially loads the products
    on<InitialProductLoaded>((event, emit) async {
      try {
        final allProducts = await repository.getProducts();
        emit(
          ProductLoadSuccess(
            allProducts: allProducts,
            filteredProducts: allProducts,
            categoryName: "",
            categoryId: null,
            searchQuery: "",
          ),
        );
      } catch (e) {
        emit(ProductLoadFailure('Failed to load initial products: $e'));
      }
    });

    // Loads all products from the repository when the app starts or is refreshed.
    on<ProductFilteredEvent>((event, emit) async {
      log("Filtering products by category: ${event.categoryName}");
      emit(ProductLoadInProgress());

      try {
        final List<Product> allProducts = await repository.getProducts();

        if (event.categoryName == "All") {
          emit(
            ProductLoadSuccess(
              allProducts: allProducts,
              filteredProducts: allProducts,
              categoryName: event.categoryName,
              categoryId: event.categoryId,
              searchQuery: "",
            ),
          );
        } else {
          final List<Product> filtered =
              allProducts.where((product) {
                log(
                  "Comparing category IDs: ${product.categoryId} == ${event.categoryId}",
                );
                return product.categoryId == event.categoryId;
              }).toList();

          emit(
            ProductLoadSuccess(
              allProducts: allProducts,
              filteredProducts: filtered,
              categoryName: event.categoryName,
              categoryId: event.categoryId,
              searchQuery: "",
            ),
          );
        }
      } catch (e) {
        emit(ProductLoadFailure('Failed to fetch products: $e'));
      }
    });
  }
}
