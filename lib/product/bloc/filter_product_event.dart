//equatable used
import 'package:equatable/equatable.dart';

class FilterProductEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitialProductLoaded extends FilterProductEvent {}

class ProductFilteredEvent extends FilterProductEvent {
  final String categoryName;

  ProductFilteredEvent(this.categoryName);

  @override
  List<Object?> get props => [categoryName];
}

class ProductSearchedEvent extends FilterProductEvent {
  final String query;
  final String category;

  ProductSearchedEvent(this.query, this.category);

  @override
  List<Object?> get props => [query, category];
}
