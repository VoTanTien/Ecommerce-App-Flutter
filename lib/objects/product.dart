import 'package:flutter/cupertino.dart';

class Product {
  String title;
  String option;
  int price;
  int? discountPrice;
  int? quantity;
  AssetImage? image;

  Product(this.title, this.option, this.price, this.discountPrice,
      this.quantity, this.image);
}