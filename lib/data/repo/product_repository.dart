import 'package:nike_shop_project/common/http_client.dart';
import 'package:nike_shop_project/data/Models/product.dart';

import '../data/product_data_source.dart';

final productRepository =
    ProductRepository(ProductRemoteDataSource(httpclient));

abstract class IProductRepository {
  Future<List<ProductEntity>> getAll(int sort);
  Future<List<ProductEntity>> search(String searchTerm);
}

class ProductRepository implements IProductRepository {
  final IProductDataSource dataSource;

  ProductRepository(this.dataSource);

  @override
  Future<List<ProductEntity>> getAll(int sort) => dataSource.getAll(sort);

  @override
  Future<List<ProductEntity>> search(String searchTerm) =>
      dataSource.search(searchTerm);
}
