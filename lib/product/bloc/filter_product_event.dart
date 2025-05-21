//equatable used
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

  ProductFilteredEvent(this.categoryName);

  @override
  List<Object?> get props => [categoryName];
}

//searches the product when user type product name
class ProductSearchedEvent extends FilterProductEvent {
  final String query;
  final String category;

  ProductSearchedEvent(this.query, this.category);

  @override
  List<Object?> get props => [query, category];
}
