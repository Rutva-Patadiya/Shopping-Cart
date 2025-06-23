import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_cart/product/data/datasources/product_data_sources.dart';
import 'package:shopping_cart/product/domain/repositories/product_repositories.dart';

import '../data/models/category_model.dart';
import '../domain/entities/product.dart';
import 'product_event.dart';
import 'product_state.dart';

/// The bloc class for managing the category-related operations
class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc() : super(EmptyCategoryState(categories: [], categoryId: null)) {
    on<CategoryLoadedEvent>(_handleCategoryList);
    on<CategorySelectedEvent>(_handleCategorySelected);
  }

  Future<void> _handleCategoryList(
    CategoryEvent event,
    Emitter<CategoryState> emit,
  ) async {
    emit(state.withLoading());
    List<CategoryModel> categories;
    ProductDataSources dataSources = ProductDataSources();
    categories = await dataSources.fetchCategories();
    log("Categories: $categories");
    if (categories.isEmpty) {
      emit(CategoryLoadFailure(categories: [], categoryId: null));
      return;
    } else {
      emit(CategoryLoadSuccess(categories: categories));
    }
  }

  Future<void> _handleCategorySelected(
    CategorySelectedEvent event,
    Emitter<CategoryState> emit,
  ) async {
    if (state is CategoryLoadSuccess) {
      // print("selected id: ${event.categoryId?.id}");
      emit(
        CategoryLoadSuccess(
          categories: state.categories,
          categoryId: event.categoryId,
        ),
      );
    }
  }
}

/// The bloc class for managing the product & category-related operations
class ProductBloc extends Bloc<FilterProductEvent, ProductState> {
  final ProductRepository productRepository;
  final ProductDataSources dataSources = ProductDataSources();

  /// constant required
  ProductBloc({required this.productRepository})
    : super(
        EmptyProductState(
          allProducts: [],
          filteredProducts: [],
          searchQuery: '',
        ),
      ) {
    // Initially loads the products
    on<InitialProductLoaded>(_handleInitialProducts);

    // Filters products
    on<ProductFilteredEvent>(_handleFilterProducts);

    // Handles product search
    on<ProductSearchedEvent>(_handleProductSearch);
  }

  /// Loads all products and categories initially
  Future<void> _handleInitialProducts(
    FilterProductEvent event,
    Emitter<ProductState> emit,
  ) async {
    // final List<CategoryModel> categories;
    log('Initial Product Loaded');
    emit(state.withLoading());

    try {
      final allProducts = await productRepository.getProducts();
      // categories = await dataSources.fetchCategories();

      // if (categories.isEmpty) {
      //   emit(
      //     ProductLoadFailure(
      //       errorMessage: 'No categories & products found',
      //       allProducts: [],
      //       filteredProducts: [],
      //       searchQuery: '',
      //     ),
      //   );
      //   return;
      // }

      emit(
        ProductLoadSuccess(
          // categories: categories,  // uncomment if categories needed
          allProducts: allProducts,
          filteredProducts: allProducts,
          categoryName: "All",
          categoryId: null,
          searchQuery: "",
        ),
      );
    } catch (e) {
      emit(
        ProductLoadFailure(
          errorMessage: e.toString(),
          allProducts: [],
          filteredProducts: [],
          searchQuery: '',
        ),
      );
    }
  }

  /// Filters products based on category and previous search query
  Future<void> _handleFilterProducts(
    ProductFilteredEvent event,
    Emitter<ProductState> emit,
  ) async {
    final currentState = state;
    final previousSearchQuery =
        currentState is ProductLoadSuccess ? currentState.searchQuery : "";

    try {
      final allProducts = await productRepository.getProducts();
      List<Product> filtered = allProducts;

      // Apply filter category-wise first
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

      // After filtering, emits the ProductLoadSuccess state
      emit(
        ProductLoadSuccess(
          // categories: await dataSources.fetchCategories(), // uncomment if categories needed
          allProducts: allProducts,
          filteredProducts: filtered,
          categoryId: event.categoryId,
          categoryName: event.categoryName,
          searchQuery: previousSearchQuery,
        ),
      );
    } catch (e) {
      emit(
        ProductLoadFailure(
          errorMessage: 'Failed to filter products',
          allProducts: [],
          filteredProducts: [],
          searchQuery: '',
          // categories: [],  // uncomment if categories needed
        ),
      );
    }
  }

  /// Handles product search based on current filters
  Future<void> _handleProductSearch(
    ProductSearchedEvent event,
    Emitter<ProductState> emit,
  ) async {
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
            // categories: await dataSources.fetchCategories(), // uncomment if categories needed
            allProducts: allProducts,
            filteredProducts: filtered,
            categoryId: currentState.categoryId,
            categoryName: currentState.categoryName,
            searchQuery: event.query, // <- Save new query (even if empty)
          ),
        );
      } catch (e) {
        emit(
          ProductLoadFailure(
            errorMessage: 'Failed to filter products',
            allProducts: [],
            filteredProducts: [],
            searchQuery: '',
            // categories: [],  // uncomment if categories needed
          ),
        );
      }
    }
  }
}

/// Bloc to load product variants for a specific product
class ProductVariantsBloc
    extends Bloc<ProductVariantEvent, ProductVariantState> {
  final ProductRepository productRepository;
  final ProductDataSources dataSources = ProductDataSources();

  ProductVariantsBloc({required this.productRepository})
    : super(ProductVariantInProgress(variants: {})) {
    on<ProductVariantsLoaded>(_handleProductVariants);
  }

  /// Loads all variants for a product
  Future<void> _handleProductVariants(
    ProductVariantsLoaded event,
    Emitter<ProductVariantState> emit,
  ) async {
    try {
      final variants = await dataSources.fetchAllVariants(event.productId);
      emit(ProductVariantsLoadSuccess(variants: variants));
    } catch (e) {
      emit(
        ProductVariantFailure(message: 'Failed to load variants', variants: {}),
      );
    }
  }
}
