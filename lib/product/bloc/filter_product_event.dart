abstract class ProductFilterEvent {}

class FilterProducts extends ProductFilterEvent {
  final String category;

  FilterProducts(this.category);
}
