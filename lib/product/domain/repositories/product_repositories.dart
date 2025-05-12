import '../enitities/product.dart';

abstract class ProductRepository {
  Future<List<Product>> getProducts();
}
