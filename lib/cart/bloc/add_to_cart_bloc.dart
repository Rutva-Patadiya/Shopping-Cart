import 'package:flutter_bloc/flutter_bloc.dart';

import '../../product/domain/entities/product.dart';
import 'add_to_cart_event.dart';
import 'add_to_cart_state.dart';

class AddToCartBloc extends Bloc<AddToCartEvent, AddToCartState> {
  final Map<Product, int> _cartItems = {};

  AddToCartBloc() : super(CartLoading()) {
    // on<AddToCart>((event, emit) async {
    //   _cartItems.add(event.product);
    //   emit(CartLoaded(List<Product>.from(_cartItems)));
    // });
    on<AddToCart>((event, emit) {
      if (_cartItems.containsKey(event.product)) {
        _cartItems[event.product] = _cartItems[event.product]! + 1;
      } else {
        _cartItems[event.product] = 1;
      }
      emit(CartLoaded(Map<Product, int>.from(_cartItems)));
    });

    on<RemoveFromCart>((event, emit) {
      if (_cartItems.containsKey(event.product)) {
        final currentQty = _cartItems[event.product]!;
        if (currentQty > 1) {
          _cartItems[event.product] = currentQty - 1;
        } else {
          _cartItems.remove(event.product);
        }
      }
      emit(CartLoaded(Map<Product, int>.from(_cartItems)));
    });
  }
}






