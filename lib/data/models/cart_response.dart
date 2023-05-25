import 'package:nike_shop_project/data/models/cart_item.dart';

class CartResponse {
  final List<CartitemEntity> cartItem;
  final int payablePrice;
  final int totalPrice;
  final int shippingCost;

  CartResponse.fromJson(Map<String, dynamic> json)
      : cartItem = CartitemEntity.pareJsonArray(json["cart_items"]),
        payablePrice = json["payable_price"],
        totalPrice = json["total_price"],
        shippingCost = json["shipping_cost"];
}
