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
            categoryName: "",
            categoryId: null,
            searchQuery: "",
          ),
        );
      } catch (e) {
        emit(ProductLoadFailure('Failed to fetch products'));
      }
    });

    //It handles product search
    // on<ProductSearchedEvent>((event, emit) async {
    //   // emit(ProductLoadInProgress());
    //   try {
    //     final List<Product> allProducts = await repository.getProducts();
    //
    //     final categoryFiltered =
    //         allProducts.where((product) {
    //           return event.category == allCategories ||
    //               product.categoryName == event.category;
    //         }).toList();
    //
    //     final searchFiltered =
    //         categoryFiltered
    //             .where(
    //               (product) => product.name.toLowerCase().contains(
    //                 event.query.toLowerCase(),
    //               ),
    //             )
    //             .toList();
    //     emit(
    //       ProductLoadSuccess(
    //         // categories: _categories,
    //         allProducts: allProducts,
    //         filteredProducts: searchFiltered,
    //         selectedCategory: event.category,
    //         searchQuery: event.query,
    //       ),
    //     );
    //   } catch (e) {
    //     emit(ProductLoadFailure('Failed to fetch products: $e'));
    //   }
    // });

    // Loads all products from the repository when the app starts or is refreshed.
    on<ProductFilteredEvent>((event, emit) async {
      log("Filtering products by category: ${event.categoryName}");

      emit(ProductLoadInProgress());

      try {
        final List<Product> allProducts = await repository.getProducts();
        if (event.categoryName == allCategories) {
          emit(
            ProductLoadSuccess(
              // categories: _categories,
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
              // categories: _categories,
              allProducts: allProducts,
              filteredProducts: filtered,
              categoryName: event.categoryName,
              categoryId: event.categoryId,
              searchQuery: "",
            ),
          );
        }
      } catch (e) {
        emit(ProductLoadFailure('Failed to fetch products:'));
      }
    });
  }
}
