import 'package:flutter/cupertino.dart';
import 'package:t_t_project/constants/image_strings.dart';
import 'package:t_t_project/objects/product.dart';

class ProductManager1 {
  static final ProductManager1 _instance = ProductManager1._internal();

  factory ProductManager1() {
    return _instance;
  }

  ProductManager1._internal();

  List<Product> products = [
    Product('Laptop ASUS VivoBook Pro 16X OLED N7600ZE L2010W', 'White' ,1200, 1000, 1 , AssetImage(lt4s)),
    Product('Realme Book(Slim) Intel Evo Core i5 11th Gen', 'White' ,1000, 899, 1 , AssetImage(lt5s)),
    Product('Laptop ASUS VivoBook 15 (2022) Core i3 10th Gen', 'White' ,1200, 1000, 1 , AssetImage(lt1s)),
    Product('Laptop HP Pavilion Ryzen 5 Hexa Core AMD R5', 'Grey' ,1000, null, 1 , const AssetImage(lt6s)),
    Product('Lenovo Intel Celeron Dual Core i3 Processor Grey', 'Grey' ,900, null, 1 , AssetImage(lt7s)),
    Product('ASUS TUF Gaming A17 Ryzen 5 Hexa Core AMD R5', 'Grey' ,1500, 1399, 1 , AssetImage(lt10s)),
    Product('Laptop acer Aspire 3 Ryzen 3 Dual Core 3250U', 'Black' ,1550, null, 1 , AssetImage(lt9s)),
    Product('Laptop HP 14s Intel Core i3 11th Gen Processor White', 'White' ,850, null, 1 , AssetImage(lt8s)),
  ];


}