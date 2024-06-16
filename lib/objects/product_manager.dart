import 'package:flutter/cupertino.dart';
import 'package:t_t_project/constants/image_strings.dart';
import 'package:t_t_project/objects/product.dart';

class ProductManager {
  static final ProductManager _instance = ProductManager._internal();

  factory ProductManager() {
    return _instance;
  }

  ProductManager._internal();

  List<Product> products = [
    Product('Laptop ASUS VivoBook Pro 16X OLED N7600ZE L2010W', 'White' ,1200, 1000, 1 , AssetImage(lt4s)),
    Product('Laptop Asus ExpertBook B9400CEA KC1013W', 'Black' ,1000, 899, 1 , AssetImage(lt2s)),
    Product('Laptop ASUS Zenbook 14 OLED UX3402VA KM085W', 'Blue' ,1100, null, 1 , AssetImage(lt3s)),
    Product('Laptop ASUS Vivobook 15 X1502ZA BQ127WKML', 'Blue' ,849, null, 1 , AssetImage(lt1s)),
  ];

// Thêm các phương thức để thao tác với danh sách addresses ở đây
void addAddress(Product newAddress) {
  products.add(newAddress);
}
//
void removeAddress(Product addressToRemove) {
  products.remove(addressToRemove);
}
}