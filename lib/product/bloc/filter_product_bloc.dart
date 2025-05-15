import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_cart/product/domain/repositories/product_repositories.dart';

import '../domain/entities/product.dart';
import 'filter_product_event.dart';
import 'filter_product_state.dart';

class ProductBloc extends Bloc<ProductFilterEvent, ProductState> {
  final ProductRepository repository;

  ProductBloc(this.repository) : super(ProductLoading()) {
    on<LoadInitialProducts>((event, emit) async {
      try {
        final allProducts = await repository.getProducts();
        emit(
          ProductLoaded(
            allProducts: allProducts,
            filteredProducts: allProducts,
          ),
        );
      } catch (e) {
        emit(ProductError('Failed to load initial products: $e'));
      }
    });

    on<SearchProduct>((event, emit) async {
      emit(ProductLoading());
      final List<Product> allProducts = await repository.getProducts();
      // emit(
      //   ProductLoaded(allProducts: allProducts, filteredProducts: allProducts),
      // );
      // if (state is ProductLoaded) {
      final categoryFiltered =
          allProducts.where((product) {
            return event.category == "All" ||
                product.category == event.category;
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
        ProductLoaded(
          allProducts: allProducts,
          filteredProducts: searchFiltered,
        ),
      );
    });
    on<FilterProducts>((event, emit) async {
      emit(ProductLoading());
      try {
        final List<Product> allProducts = await repository.getProducts();

        if (event.category == "All") {
          emit(
            ProductLoaded(
              allProducts: allProducts,
              filteredProducts: allProducts,
            ),
          );
        } else {
          final List<Product> filtered =
              allProducts
                  .where((product) => product.category == event.category)
                  .toList();

          emit(
            ProductLoaded(allProducts: allProducts, filteredProducts: filtered),
          );
        }
      } catch (e) {
        emit(ProductError('Failed to fetch products: $e'));
      }
    });
  }
}
