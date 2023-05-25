import 'package:nike_shop_project/data/models/product.dart';

class CartitemEntity {
  final ProductEntity product;
  final int id;
  final int count;

  CartitemEntity.fromjson(Map<String, dynamic> json)
      : product = ProductEntity.fromJson(json["product"]),
        id = json["cart_item_id"],
        count = json["count"];

  static List<CartitemEntity> pareJsonArray(List<dynamic> jsonArray) {
    final List<CartitemEntity> cartItems = [];
    jsonArray.forEach((element) {
      cartItems.add(CartitemEntity.fromjson(element));
    });
    return cartItems;
  }
}
