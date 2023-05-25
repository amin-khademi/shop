import 'package:dio/dio.dart';
import 'package:nike_shop_project/data/models/cart_response.dart';

import '../models/cart_item.dart';

abstract class ICartDataSource {
  Future<CartResponse> add(int productId);
  Future<CartResponse> changeCount(int cartItemId, int count);
  Future<void> delete(int cartItemId);
  Future<int> count();
  Future<CartResponse> getAll();
}

class CartRemoteDataSource implements ICartDataSource {
  final Dio httpClient;

  CartRemoteDataSource(this.httpClient);

  @override
  Future<CartResponse> add(int productId) async {
    final response =
        await httpClient.post("cart/add", data: {"product_id": productId});
    return CartResponse.fromJson(response.data);
  }

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
  Future<CartResponse> getAll() async {
    final reaponse = await httpClient.get("cart/list");
    return CartResponse.fromJson(reaponse.data);
  }
}
