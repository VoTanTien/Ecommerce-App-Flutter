import 'package:t_t_project/objects/product.dart';

import 'cart_product.dart';

class CartItemData {
  CartProduct cartProduct;
  Product product;

  CartItemData({required this.cartProduct, required this.product});
}