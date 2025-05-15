import 'package:equatable/equatable.dart';
import 'package:shopping_cart/product/domain/entities/product.dart';

class AddToCartEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class AddToCart extends AddToCartEvent {
  final Product product;

  AddToCart(this.product);

  @override
  List<Object?> get props => [product];
}

class RemoveFromCart extends AddToCartEvent {
  final Product product;

  RemoveFromCart(this.product);
}
