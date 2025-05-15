import 'package:equatable/equatable.dart';
import 'package:shopping_cart/product/domain/entities/product.dart';

class AddToCartState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CartLoading extends AddToCartState {}

class CartLoaded extends AddToCartState {
  final Map<Product, int> cartItems;

  CartLoaded(this.cartItems);

  @override
  List<Object?> get props => [cartItems];
}

class CartError extends AddToCartState {
  final String message;

  CartError(this.message);
}

