//equatable used
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

//equatable to compare the instance efficiently
class FilterProductEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

//triggers when the app loads
class InitialProductLoaded extends FilterProductEvent {}

//triggers when user select the image of category
class ProductFilteredEvent extends FilterProductEvent {
  final String categoryName;
  final DocumentReference? categoryId;

  ProductFilteredEvent(this.categoryName, this.categoryId);

  @override
  List<Object?> get props => [categoryName];
}

// searches the product when user type product name
class ProductSearchedEvent extends FilterProductEvent {
  final String query;

  ProductSearchedEvent(this.query);

  @override
  List<Object?> get props => [query];
}

class ProductSizeEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

//to handle the size of the product
class ProductSizeLoaded extends ProductSizeEvent {
  final String productId;

  ProductSizeLoaded(this.productId);
}

//This Event is used to handle the color of the product in product_details page
class ColorEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

//It is called when the product color is loaded in product_details page
class ProductColorLoaded extends ColorEvent {
  final String productId;

  ProductColorLoaded(this.productId);
}

//This Event is used to handle the weight of the product in product_details page
// class ProductWeightEvent extends Equatable {
//   @override
//   List<Object?> get props => [];
// }
//
// //This is called when the product weight is loaded in product_details page
// class ProductWeightLoaded extends ProductWeightEvent {
//   final Product product;
//
//   ProductWeightLoaded(this.product);
// }
