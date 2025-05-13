//equatable used
import 'package:equatable/equatable.dart';

class ProductFilterEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadInitialProducts extends ProductFilterEvent {}

class FilterProducts extends ProductFilterEvent {
  final String category;

  FilterProducts(this.category);

  @override
  List<Object?> get props => [category];
}
