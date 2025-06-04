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
