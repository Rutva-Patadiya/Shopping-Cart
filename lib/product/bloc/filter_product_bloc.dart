import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_cart/product/domain/repositories/product_repositories.dart';

import '../domain/entities/product.dart';
import 'filter_product_event.dart';
import 'filter_product_state.dart';

class ProductBloc extends Bloc<FilterProductEvent, ProductState> {
  final ProductRepository repository;

  ProductBloc(this.repository) : super(ProductLoadInProgress()) {
    on<InitialProductLoaded>((event, emit) async {
      try {
        final allProducts = await repository.getProducts();
        emit(
          ProductLoadSuccess(
            allProducts: allProducts,
            filteredProducts: allProducts,
            selectedCategory: "All",
            searchQuery: "",
          ),
        );
      } catch (e) {
        emit(ProductLoadFailure('Failed to load initial products: $e'));
      }
    });

    on<ProductSearchedEvent>((event, emit) async {
      // emit(ProductLoadInProgress());
      try {
        final List<Product> allProducts = await repository.getProducts();

        final categoryFiltered =
            allProducts.where((product) {
              return event.category == "All" ||
                  product.categoryName == event.category;
            }).toList();

        final searchFiltered =
            categoryFiltered
                .where(
                  (product) => product.name.toLowerCase().contains(
                    event.query.toLowerCase(),
                  ),
                )
                .toList();
        emit(
          ProductLoadSuccess(
            allProducts: allProducts,
            filteredProducts: searchFiltered,
            selectedCategory: event.category,
            searchQuery: event.query,
          ),
        );
      } catch (e) {
        emit(ProductLoadFailure('Failed to fetch products: $e'));
      }
    });
    on<ProductFilteredEvent>((event, emit) async {
      print("Filtering products by category: ${event.categoryName}");

      emit(ProductLoadInProgress());
      try {
        final List<Product> allProducts = await repository.getProducts();
        if (event.categoryName == "All") {
          emit(
            ProductLoadSuccess(
              allProducts: allProducts,
              filteredProducts: allProducts,
              selectedCategory: "All",
              searchQuery: "",
            ),
          );
        } else {
          final List<Product> filtered =
              allProducts.where((product) {
                return product.categoryName == event.categoryName;
              }).toList();
          log(event.categoryName);

          emit(
            ProductLoadSuccess(
              allProducts: allProducts,
              filteredProducts: filtered,
              selectedCategory: event.categoryName,
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
