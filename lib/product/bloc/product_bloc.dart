import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_cart/product/data/datasources/product_data_sources.dart';
import 'package:shopping_cart/product/data/models/product_size_model.dart';
import 'package:shopping_cart/product/domain/repositories/product_repositories.dart';

import '../data/models/category_model.dart';
import '../domain/entities/product.dart';
import 'product_event.dart';
import 'product_state.dart';

//The bloc class is for managing the product & category related operation
class ProductBloc extends Bloc<FilterProductEvent, ProductState> {
  final ProductRepository productRepository;
  final ProductDataSources dataSources = ProductDataSources();
  static const allCategories = "All";

  ProductBloc({required this.productRepository})
    : super(ProductLoadInProgress()) {
    //Initially loads the products

    on<InitialProductLoaded>((event, emit) async {
      //for storing the categories
      final List<CategoryModel> categories;
      log('Initial Product Loaded');
      emit(ProductLoadInProgress());
      try {
        final allProducts = await productRepository.getProducts();
        categories = await dataSources.fetchCategories();

        if (categories.isEmpty) {
          emit(ProductLoadFailure("No categories & products found"));
          return;
        }

        emit(
          ProductLoadSuccess(
            categories: categories,
            allProducts: allProducts,
            filteredProducts: allProducts,
            categoryName: "All",
            categoryId: null,
            searchQuery: "",
          ),
        );
      } catch (e) {
        emit(ProductLoadFailure(e.toString()));
      }
    });

    // Loads all products from the repository when the app starts

    on<ProductFilteredEvent>((event, emit) async {
      final currentState = state;
      final previousSearchQuery =
          currentState is ProductLoadSuccess ? currentState.searchQuery : "";

      try {
        final allProducts = await productRepository.getProducts();

        List<Product> filtered = allProducts;

        // Apply filter category wise first
        if (event.categoryId != null) {
          filtered =
              filtered.where((p) => p.categoryId == event.categoryId).toList();
        }

        // Apply search filter
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

        //after filtering, emits the ProductLoadSuccess state
        emit(
          ProductLoadSuccess(
            categories: await dataSources.fetchCategories(),
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
        try {
          final allProducts = await productRepository.getProducts();

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
              categories: await dataSources.fetchCategories(),
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

    on<ProductSizeLoaded>((event, emit) async {
      final List<ProductSizeModel> productSize;

      try {
        productSize = await dataSources.fetchCategoryAndSizes(event.product);

        // Collect all size strings
        final List<String> sizeList =
            productSize.expand((model) => model.sizes).toList();

        emit(ProductSizeLoadSuccess(productSize: sizeList, sizeList: ''));
      } catch (e) {
        emit(ProductLoadFailure("Failed to load sizes"));
      }
    });
  }
}

class ProductColorBloc extends Bloc<ColorEvent, ColorState> {
  final ProductDataSources dataSources = ProductDataSources();

  ProductColorBloc() : super(ProductColorInProgress()) {
    on<ProductColorLoaded>((event, emit) async {
      try {
        final productColor = await dataSources.fetchColors(event.product);

        final colorList = productColor.expand((model) => model.colors).toList();

        print("Fetched colors: $colorList");

        emit(ProductColorLoadSuccess(productColor: '', colorList: colorList));
      } catch (e) {
        emit(ProductColorLoadFailure("Failed to load colors"));
      }
    });
  }
}
//the bloc when the color is written only in the color collection
// class ProductColorBloc extends Bloc<ColorEvent, ColorState> {
//   final ProductDataSources dataSources = ProductDataSources();
//
//   ProductColorBloc() : super(ProductColorInProgress()) {
//     on<ProductColorLoaded>((event, emit) async {
//       try {
//         final productColor = await dataSources.fetchColors(event.product);
//
//         final colorList = productColor.expand((model) => model.colors).toList();
//
//         print("Fetched colors: $colorList");
//
//         emit(ProductColorLoadSuccess(productColor: '', colorList: colorList));
//       } catch (e) {
//         emit(ProductColorLoadFailure("Failed to load colors"));
//       }
//     });
//   }
// }

// class ProductWeightBloc extends Bloc<ProductWeightEvent, WeightState> {
//   ProductWeightBloc(super.initialState);
// }
