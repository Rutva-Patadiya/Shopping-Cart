//equatable used
import 'package:equatable/equatable.dart';

class FilterProductEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitialProductLoaded extends FilterProductEvent {}

class ProductFilteredEvent extends FilterProductEvent{
  final String category;

  ProductFilteredEvent(this.category);

  @override
  List<Object?> get props => [category];
}

class ProductSearchedEvent extends FilterProductEvent {
  final String query;
  final String category;

  ProductSearchedEvent(this.query, this.category);

  @override
  List<Object?> get props => [query];
}
