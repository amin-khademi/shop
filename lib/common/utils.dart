import 'package:flutter/widgets.dart';

final defaultScrollPhysics = BouncingScrollPhysics();

extension PriceLable on int {
  String get WithPriceLable => "$this  تومان";
}
