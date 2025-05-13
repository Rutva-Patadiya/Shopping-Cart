import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repositories.dart';
import '../datasources/product_data_sources.dart';
// This is the implementation of the ProductRepository interface. fetches the products from ProductDataSources.

// This class interacts with the data source to fetch product data. It is provided to the ProductBloc.
class ProductRepositoryImpl implements ProductRepository {
  final ProductDataSources remoteDataSource;

  ProductRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Product>> getProducts() async {
    final models = await remoteDataSource.fetchProducts();

    return models.map((model) => model.toEntity()).toList();
  }
}
