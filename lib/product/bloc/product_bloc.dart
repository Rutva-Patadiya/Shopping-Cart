import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_cart/product/data/datasources/product_data_sources.dart';
import 'package:shopping_cart/product/domain/repositories/product_repositories.dart';

import '../data/models/category_model.dart';
import '../domain/entities/product.dart';
import 'product_event.dart';
import 'product_state.dart';

/// Bloc for managing category-related operations
class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final ProductDataSources dataSources;
  CategoryBloc({required this.dataSources})
    : super(EmptyCategoryState(categories: [], categoryId: null)) {
    on<CategoryLoadedEvent>(_onCategoryLoaded);
    on<CategorySelectedEvent>(_onCategorySelected);
  }

  Future<void> _onCategoryLoaded(
    CategoryEvent event,
    Emitter<CategoryState> emit,
  ) async {
    emit(state.withLoading());
    List<CategoryModel> categories = await dataSources.fetchCategories();
    log("Categories: $categories");

    if (categories.isEmpty) {
      emit(CategoryLoadFailure(categories: [], categoryId: null));
    } else {
      emit(
        CategoryLoadSuccess(
          categories: categories,
          categoryId: state.categoryId,
        ),
      );
    }
  }

  Future<void> _onCategorySelected(
    CategorySelectedEvent event,
    Emitter<CategoryState> emit,
  ) async {
    if (state is CategoryLoadSuccess) {
      emit(
        CategoryLoadSuccess(
          categories: state.categories,
          categoryId: event.categoryId,
        ),
      );
    }
  }
}

/// Bloc for managing product and category-related operations
class ProductBloc extends Bloc<FilterProductEvent, ProductState> {
  final ProductRepository productRepository;
  final ProductDataSources dataSources;

  ProductBloc({required this.productRepository, required this.dataSources})
    : super(
        EmptyProductState(
          allProducts: [],
          filteredProducts: [],
          searchQuery: '',
        ),
      ) {
    on<InitialProductLoaded>(_onInitialProductLoaded);
    on<ProductFilteredEvent>(_onProductsFiltered);
    on<ProductSearchedEvent>(_onProductsSearched);
  }

  Future<void> _onInitialProductLoaded(
    FilterProductEvent event,
    Emitter<ProductState> emit,
  ) async {
    log('Initial Product Loaded');
    emit(state.withLoading());

    try {
      final allProducts = await productRepository.getProducts();

      emit(
        ProductLoadSuccess(
          allProducts: allProducts,
          filteredProducts: allProducts,
          categoryName: "All",
          categoryId: null,
          searchQuery: "",
        ),
      );
    } on FirebaseException catch (e) {
      if (e.code == 'unavailable') {
        emit(
          ProductLoadFailure(
            errorMessage: 'No internet connection',
            allProducts: [],
            filteredProducts: [],
            searchQuery: '',
          ),
        );
      } else {
        emit(
          ProductLoadFailure(
            errorMessage: e.message ?? 'Failed to load products',
            allProducts: [],
            filteredProducts: [],
            searchQuery: '',
          ),
        );
      }
    } catch (e) {
      emit(
        ProductLoadFailure(
          errorMessage: e.toString().contains('No internet connection')
              ? 'No internet connection'
              : 'Failed to load products',
          allProducts: [],
          filteredProducts: [],
          searchQuery: '',
        ),
      );
    }
  }

  Future<void> _onProductsFiltered(
    ProductFilteredEvent event,
    Emitter<ProductState> emit,
  ) async {
    final currentState = state;
    final previousSearchQuery =
        currentState is ProductLoadSuccess ? currentState.searchQuery : "";

    try {
      final allProducts = await productRepository.getProducts();
      List<Product> filtered = allProducts;

      if (event.categoryId != null) {
        filtered =
            filtered.where((p) => p.categoryId == event.categoryId).toList();
      }

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
    }
    on FirebaseException catch(e) {
      if (e.code == 'unavailable') {
        emit(
          ProductLoadFailure(
            errorMessage: 'Network Error',
            allProducts: [],
            filteredProducts: [],
            searchQuery: '',
          ),
        );
      }
      else if(e.code == 'not-found'){
        emit(
          ProductLoadFailure(
            errorMessage: 'Collection Not Found',
            allProducts: [],
            filteredProducts: [],
            searchQuery: '',
          ),
        );
      }
    }
    catch (e) {
      emit(
        ProductLoadFailure(
          errorMessage: 'Failed to filter products',
          allProducts: [],
          filteredProducts: [],
          searchQuery: '',
        ),
      );
    }
  }

  Future<void> _onProductsSearched(
    ProductSearchedEvent event,
    Emitter<ProductState> emit,
  ) async {
    final currentState = state;
    if (currentState is ProductLoadSuccess) {
      try {
        final allProducts = await productRepository.getProducts();
        List<Product> filtered = allProducts;

        if (currentState.categoryId != null) {
          filtered =
              filtered
                  .where((p) => p.categoryId == currentState.categoryId)
                  .toList();
        }

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
            searchQuery: event.query,
          ),
        );
      } catch (e) {
        emit(
          ProductLoadFailure(
            errorMessage: 'Failed to filter products',
            allProducts: [],
            filteredProducts: [],
            searchQuery: '',
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
  final ProductDataSources dataSources;

  ProductVariantsBloc({
    required this.productRepository,
    required this.dataSources,
  }) : super(ProductVariantInProgress(variants: {})) {
    on<ProductVariantsLoaded>(_onVariantsLoaded);
  }

  Future<void> _onVariantsLoaded(
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
