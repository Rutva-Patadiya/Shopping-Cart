import 'package:flutter_bloc/flutter_bloc.dart';

import '../../product/domain/entities/product.dart';
import 'add_to_cart_event.dart';
import 'add_to_cart_state.dart';

class AddToCartBloc extends Bloc<AddToCartEvent, AddToCartState> {
  final Map<Product, int> _cartItems = {};

  AddToCartBloc() : super(CartLoading()) {
    on<AddToCart>((event, emit) {
      if (_cartItems.containsKey(event.product)) {
        // it'll return the value for that product
        _cartItems[event.product] = _cartItems[event.product]! + 1;
      } else {
        _cartItems[event.product] = 1;
      }
      emit(CartLoaded(Map<Product, int>.from(_cartItems)));
    });

    on<RemoveFromCart>((event, emit) {
      if (_cartItems.containsKey(event.product)) {
        final quantity = _cartItems[event.product]!;
        //if quantity > 1 then decrease it
        if (quantity > 1) {
          _cartItems[event.product] = quantity - 1;
        } else {
          //if only one then remove it
          _cartItems.remove(event.product);
        }
      }
      emit(CartLoaded(Map<Product, int>.from(_cartItems)));
    });
  }
}
