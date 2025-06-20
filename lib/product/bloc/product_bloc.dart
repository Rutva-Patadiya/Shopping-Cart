import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_cart/product/data/datasources/product_data_sources.dart';
import 'package:shopping_cart/product/domain/repositories/product_repositories.dart';

import '../data/models/category_model.dart';
import '../domain/entities/product.dart';
import 'product_event.dart';
import 'product_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc(super.initialState);
}

//The bloc class is for managing the product & category related operation
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
          // categories: [],
        ),
      ) {
    //Initially loads the products
    on<InitialProductLoaded>(_handleInitialProducts);
    //filters products
    on<ProductFilteredEvent>(_handleFilterProducts);
    //handle product search
    on<ProductSearchedEvent>(_handleProductSearch);
  }

  Future<void> _handleInitialProducts(
    FilterProductEvent event,
    Emitter<ProductState> emit,
  ) async {
    final List<CategoryModel> categories;
    log('Initial Product Loaded');
    emit(state.withLoading());
    try {
      final allProducts = await productRepository.getProducts();
      categories = await dataSources.fetchCategories();

      if (categories.isEmpty) {
        emit(
          ProductLoadFailure(
            errorMessage: 'No categories & products found',
            allProducts: [],
            filteredProducts: [],
            searchQuery: '',
            // categories: [],
          ),
        );
        return;
      }

      emit(
        ProductLoadSuccess(
          // categories: categories,
          allProducts: allProducts,
          filteredProducts: allProducts,
          categoryName: "All",
          categoryId: null,
          searchQuery: "",
        ),
      );
    } catch (e) {
      // emit(ProductLoadFailure(e.toString()));
    }
  }

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
          // categories: await dataSources.fetchCategories(),
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
          // categories: [],
        ),
      );
    }
  }

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
            // categories: await dataSources.fetchCategories(),
            allProducts: allProducts,
            filteredProducts: filtered,
            categoryId: currentState.categoryId,
            categoryName: currentState.categoryName,
            searchQuery: event.query, // <- save new query (even if empty)
          ),
        );
      } catch (e) {
        emit(
          ProductLoadFailure(
            errorMessage: 'Failed to filter products',
            allProducts: [],
            filteredProducts: [],
            searchQuery: '',
            // categories: [],
          ),
        );
      }
    }
  }
}

class ProductVariantsBloc
    extends Bloc<ProductVariantEvent, ProductVariantState> {
  final ProductRepository productRepository;
  final ProductDataSources dataSources = ProductDataSources();

  ProductVariantsBloc({required this.productRepository})
    : super(ProductVariantInProgress(variants: {})) {
    on<ProductVariantsLoaded>(_handleProductVariants);
  }

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

// on<InitialProductLoaded>((event, emit) async {
//   //for storing the categories
//   final List<CategoryModel> categories;
//   log('Initial Product Loaded');
//   emit(state.withLoading());
//   try {
//     final allProducts = await productRepository.getProducts();
//     categories = await dataSources.fetchCategories();
//
//     if (categories.isEmpty) {
//       // emit(ProductLoadFailure("No categories & products found"));
//       return;
//     }
//
//     emit(
//       ProductLoadSuccess(
//         categories: categories,
//         allProducts: allProducts,
//         filteredProducts: allProducts,
//         categoryName: "All",
//         categoryId: null,
//         searchQuery: "",
//       ),
//     );
//   } catch (e) {
//     // emit(ProductLoadFailure(e.toString()));
//   }
// });

// Loads all products from the repository when the app starts

// on<ProductFilteredEvent>((event, emit) async {
//   final currentState = state;
//   final previousSearchQuery =
//       currentState is ProductLoadSuccess ? currentState.searchQuery : "";
//
//   try {
//     final allProducts = await productRepository.getProducts();
//
//     List<Product> filtered = allProducts;
//
//     // Apply filter category wise first
//     if (event.categoryId != null) {
//       filtered =
//           filtered.where((p) => p.categoryId == event.categoryId).toList();
//     }
//
//     // Apply search filter
//     if (previousSearchQuery.isNotEmpty) {
//       filtered =
//           filtered
//               .where(
//                 (p) => p.name.toLowerCase().contains(
//                   previousSearchQuery.toLowerCase(),
//                 ),
//               )
//               .toList();
//     }
//
//     //after filtering, emits the ProductLoadSuccess state
//     emit(
//       ProductLoadSuccess(
//         categories: await dataSources.fetchCategories(),
//         allProducts: allProducts,
//         filteredProducts: filtered,
//         categoryId: event.categoryId,
//         categoryName: event.categoryName,
//         searchQuery: previousSearchQuery,
//       ),
//     );
//   } catch (e) {
//     emit(
//       ProductLoadFailure(
//         errorMessage: 'Failed to filter products',
//         allProducts: [],
//         filteredProducts: [],
//         searchQuery: '',
//         categories: [],
//       ),
//     );
//   }
// });
//
// //It handles product search
// on<ProductSearchedEvent>((event, emit) async {
//   final currentState = state;
//
//   if (currentState is ProductLoadSuccess) {
//     try {
//       final allProducts = await productRepository.getProducts();
//
//       List<Product> filtered = allProducts;
//
//       // Reuse current category filter
//       if (currentState.categoryId != null) {
//         filtered =
//             filtered
//                 .where((p) => p.categoryId == currentState.categoryId)
//                 .toList();
//       }
//
//       // Apply new search query (even if it's empty)
//       if (event.query.isNotEmpty) {
//         filtered =
//             filtered
//                 .where(
//                   (p) => p.name.toLowerCase().contains(
//                     event.query.toLowerCase(),
//                   ),
//                 )
//                 .toList();
//       }
//
//       emit(
//         ProductLoadSuccess(
//           categories: await dataSources.fetchCategories(),
//           allProducts: allProducts,
//           filteredProducts: filtered,
//           categoryId: currentState.categoryId,
//           categoryName: currentState.categoryName,
//           searchQuery: event.query, // <- save new query (even if empty)
//         ),
//       );
//     } catch (e) {
//       // emit(ProductLoadFailure('Failed to filter products'));
//     }
//   }
// });

// on<ProductVariantsLoaded>((event, emit) async {
// try {
// final variants = await dataSources.fetchAllVariants(event.productId);
// emit(ProductVariantsLoadSuccess(variants));
// } catch (e) {
// emit(ProductVariantFailure("Failed to load variants"));
// }
// });
