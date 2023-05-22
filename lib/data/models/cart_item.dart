import 'package:nike_shop_project/data/models/product.dart';

class CartitemEntity {
  final ProductEntity product;
  final int id;
  final int count;

  CartitemEntity.fromjson(Map<String, dynamic> json)
      : product = ProductEntity.fromJson(json),
        id = json["cart_item_id"],
        count = json["count"];
}
