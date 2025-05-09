import 'package:flutter_bloc/flutter_bloc.dart';

import '../product_list.dart';
import 'filter_product_event.dart';
import 'filter_product_state.dart';

class ProductFilterBloc extends Bloc<ProductFilterEvent, ProductFilterState> {
  ProductFilterBloc() : super(ProductFilterInitial()) {
    on<FilterProducts>(_onFilterProducts);
  }

  Future<void> _onFilterProducts(
    FilterProducts event,
    Emitter<ProductFilterState> emit,
  ) async {
    emit(ProductFilterLoading());

    try {
      final allProducts = await fetchProducts();

      if (event.category == "All") {
        emit(ProductFilterLoaded(allProducts));
      } else {
        final filtered =
            allProducts
                .where((product) => product.category == event.category)
                .toList();
        emit(ProductFilterLoaded(filtered));
      }
    } catch (e) {
      emit(ProductFilterError('Failed to load products'));
    }
  }
}
