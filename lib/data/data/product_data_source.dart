import 'package:dio/dio.dart';
import 'package:nike_shop_project/common/validator.dart';

import '../Models/product.dart';

abstract class IProductDataSource {
  Future<List<ProductEntity>> getAll(int sort);
  Future<List<ProductEntity>> search(String searchTerm);
}

class ProductRemoteDataSource
    with HttpResponseValidator
    implements IProductDataSource {
  final Dio httpClient;

  ProductRemoteDataSource(this.httpClient);
  @override
  Future<List<ProductEntity>> getAll(int sort) async {
    final response = await httpClient.get("product/list?sort=$sort");
    validator(response);
    final product = <ProductEntity>[];
    (response.data as List).forEach((element) {
      product.add(ProductEntity.fromJson(element));
    }); //شامل اطلاعاتی است که از سرور یرای می اید
    return product;
  }

  @override
  Future<List<ProductEntity>> search(String searchTerm) async {
    final response = await httpClient.get("product/search?q=$searchTerm");
    validator(response);
    final products = <ProductEntity>[];
    (response.data as List).forEach((element) {
      products.add(ProductEntity.fromJson(element));
    });
    return products;
  }
}
