import 'package:nike_shop_project/common/http_client.dart';
import 'package:nike_shop_project/data/Models/product.dart';

import '../data/product_data_source.dart';

final productRepository = ProductRepository(ProductRemoteDataSoure(httpclient));

abstract class IProductRepository {
  Future<List<ProductEntity>> getAll(int sort);
  Future<List<ProductEntity>> search(String searchTerm);
}

class ProductRepository implements IProductRepository {
  final IProductDataSouce dataSouce;

  ProductRepository(this.dataSouce);

  @override
  Future<List<ProductEntity>> getAll(int sort) => dataSouce.getAll(sort);

  @override
  Future<List<ProductEntity>> search(String searchTerm) =>
      dataSouce.search(searchTerm);
}