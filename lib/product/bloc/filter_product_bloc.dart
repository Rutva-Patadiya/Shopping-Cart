import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_cart/product/data/models/product_model.dart';
import 'package:shopping_cart/product/domain/repositories/product_repositories.dart';

import 'filter_product_event.dart';
import 'filter_product_state.dart';

class ProductBloc extends Bloc<ProductFilterEvent, ProductState> {
  final ProductRepository repository;

  ProductBloc(this.repository) : super(ProductLoading()) {
    on<FilterProducts>((event, emit) async {
      emit(ProductLoading());

      try {
        final List<ProductModel> allProducts =
            (await repository.getProducts())
                .cast<ProductModel>(); // from your original code

        if (event.category == "All") {
          emit(ProductLoaded(allProducts));
        } else {
          final List<ProductModel> filtered =
              allProducts
                  .where((product) => product.category == event.category)
                  .toList();

          emit(ProductLoaded(filtered));
        }
      } catch (e) {
        emit(ProductError('Failed to fetch products: $e'));
      }
    });
  }
}
