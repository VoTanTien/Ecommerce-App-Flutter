import 'package:t_t_project/objects/order_product.dart';
import 'package:t_t_project/objects/product.dart';

class OrderItemData {
  OrderProduct orderProduct;
  Product product;

  OrderItemData({required this.orderProduct , required this.product});
}