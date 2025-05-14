import 'package:flutter_bloc/flutter_bloc.dart';

import '../../product/domain/entities/product.dart';
import 'add_to_cart_event.dart';
import 'add_to_cart_state.dart';

class AddToCartBloc extends Bloc<AddToCartEvent, AddToCartState> {
  final List<Product> _cartItems = [];

  AddToCartBloc() : super(CartLoading()) {
    on<AddToCart>((event, emit) async {
      _cartItems.add(event.product);
      emit(CartLoaded(List<Product>.from(_cartItems)));
    });
  }
}
