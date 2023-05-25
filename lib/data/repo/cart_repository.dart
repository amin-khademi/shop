import 'dart:ffi';

import 'package:nike_shop_project/common/http_client.dart';
import 'package:nike_shop_project/data/data/cart_data_source.dart';
import 'package:nike_shop_project/data/models/cart_item.dart';
import 'package:nike_shop_project/data/models/cart_response.dart';

final cartRepository = CartRepository(CartRemoteDataSource(httpclient));

abstract class ICartRepository extends ICartDataSource {}

class CartRepository implements ICartRepository {
  final ICartDataSource dataSource;

  CartRepository(this.dataSource);
  @override
  Future<CartResponse> add(int productId) => dataSource.add(productId);

  @override
  Future<CartResponse> changeCount(int cartItemId, int count) {
    // TODO: implement changeCount
    throw UnimplementedError();
  }

  @override
  Future<int> count() {
    // TODO: implement count
    throw UnimplementedError();
  }

  @override
  Future<void> delete(int cartItemId) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<CartResponse> getAll() => dataSource.getAll();
}
