import 'dart:ffi';

import 'package:nike_shop_project/data/models/cart_item.dart';
import 'package:nike_shop_project/data/models/cart_response.dart';

abstract class ICartRepository {
  Future<CartResponse> add(int productId);
  Future<CartResponse> changeCount(int cartItemId, int count);
  Future<void> delete(int cartItemId);
  Future<int> count();
  Future<List<CartitemEntity>> getAll();
}
