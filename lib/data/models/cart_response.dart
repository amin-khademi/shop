class CartResponse {
  final int cartItem;
  final int productId;
  final int count;

  CartResponse(this.cartItem, this.productId, this.count);

  CartResponse.fromJson(Map<String, dynamic> json)
      : cartItem = json["id"],
        productId = json["product_id"],
        count = json["count"];
}
