import 'dart:convert';

class ProductSort {
  static const lastest = 0;
  static const popular = 1;
  static const priceHighToLow = 2;
  static const priceLowToHigh = 3;
}

class ProductEntity {
  final int id;
  final String title;
  final int price;
  final int discount;
  final String image;
  final int previousprice;

  ProductEntity.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        title = json["title"],
        price = json["price"],
        discount = json["discount"],
        image = json["image"],
        previousprice = json["previous_price"] ?? json["price"];
}
