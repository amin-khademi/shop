class AddToCartResponse {
  final int cartItem;
  final int productId;
  final int count;

  AddToCartResponse(this.cartItem, this.productId, this.count);

  AddToCartResponse.fromJson(Map<String, dynamic> json)
      : cartItem = json["id"],
        productId = json["product_id"],
        count = json["count"];
}
