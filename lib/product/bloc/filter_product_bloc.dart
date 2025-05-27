import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_cart/product/data/datasources/product_data_sources.dart';
import 'package:shopping_cart/product/data/models/category_model.dart';
import 'package:shopping_cart/product/domain/repositories/product_repositories.dart';

import '../domain/entities/product.dart';
import 'filter_product_event.dart';
import 'filter_product_state.dart';

//category bloc is for managing the category related operation
class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final ProductDataSources dataSources = ProductDataSources();

  CategoryBloc() : super(CategoryLoadInProgress()) {
    on<CategoryLoadedEvent>((event, emit) async {
      List<CategoryModel> categories = [];

      try {
        categories = await dataSources.fetchCategories();
        emit(CategoryLoadSuccess(categories));
      } catch (e) {
        emit(CategoryLoadFailure("Failed to load categories"));
      }
    });
  }
}

//The bloc class is for managing the product related operation
class ProductBloc extends Bloc<FilterProductEvent, ProductState> {
  final ProductRepository repository;

  // final List<CategoryModel> _categories = [];
  final ProductDataSources dataSources = ProductDataSources();
  static const allCategories = "All";

  ProductBloc(this.repository) : super(ProductLoadInProgress()) {
    //Initially loads the products
    on<InitialProductLoaded>((event, emit) async {
      log('Initial Product Loaded');
      try {
        final allProducts = await repository.getProducts();
        emit(
          ProductLoadSuccess(
            // categories: _categories,
            allProducts: allProducts,
            filteredProducts: allProducts,
            categoryName: "All",
            categoryId: null,
            searchQuery: "",
          ),
        );
      } catch (e) {
        emit(ProductLoadFailure('Failed to fetch products'));
      }
    });

    // Loads all products from the repository when the app starts

    on<ProductFilteredEvent>((event, emit) async {
      final currentState = state;
      final previousSearchQuery =
          currentState is ProductLoadSuccess ? currentState.searchQuery : "";

      // emit(ProductLoadInProgress());

      try {
        final allProducts = await repository.getProducts();

        List<Product> filtered = allProducts;

        // Apply filter category wise first
        if (event.categoryId != null) {
          filtered =
              filtered.where((p) => p.categoryId == event.categoryId).toList();
        }

        // Apply previous search filter
        if (previousSearchQuery.isNotEmpty) {
          filtered =
              filtered
                  .where(
                    (p) => p.name.toLowerCase().contains(
                      previousSearchQuery.toLowerCase(),
                    ),
                  )
                  .toList();
        }

        emit(
          ProductLoadSuccess(
            allProducts: allProducts,
            filteredProducts: filtered,
            categoryId: event.categoryId,
            categoryName: event.categoryName,
            searchQuery: previousSearchQuery,
          ),
        );
      } catch (e) {
        emit(ProductLoadFailure('Failed to filter products'));
      }
    });

    //It handles product search

    on<ProductSearchedEvent>((event, emit) async {
      final currentState = state;

      if (currentState is ProductLoadSuccess) {
        // emit(ProductLoadInProgress());

        try {
          final allProducts = await repository.getProducts();

          List<Product> filtered = allProducts;

          // Reuse current category filter
          if (currentState.categoryId != null) {
            filtered =
                filtered
                    .where((p) => p.categoryId == currentState.categoryId)
                    .toList();
          }

          // Apply new search query (even if it's empty)
          if (event.query.isNotEmpty) {
            filtered =
                filtered
                    .where(
                      (p) => p.name.toLowerCase().contains(
                        event.query.toLowerCase(),
                      ),
                    )
                    .toList();
          }

          emit(
            ProductLoadSuccess(
              allProducts: allProducts,
              filteredProducts: filtered,
              categoryId: currentState.categoryId,
              categoryName: currentState.categoryName,
              searchQuery: event.query, // <- save new query (even if empty)
            ),
          );
        } catch (e) {
          emit(ProductLoadFailure('Failed to filter products'));
        }
      }
    });
  }
}
