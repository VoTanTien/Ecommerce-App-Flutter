import 'package:flutter/material.dart';
import 'package:t_t_project/screens/choose_address.dart';
import 'package:t_t_project/screens/home.dart';
import 'package:t_t_project/screens/liked.dart';
import 'package:t_t_project/screens/loginscreens/login.dart';
import 'package:t_t_project/screens/loginscreens/start.dart';
import 'package:t_t_project/screens/new_address.dart';
import 'package:t_t_project/screens/order.dart';
import 'package:t_t_project/screens/product_detail.dart';
import 'package:t_t_project/screens/success.dart';


void main() {
  runApp( MaterialApp(
    home: SafeArea(
      child: homeScreen(),
    ),debugShowCheckedModeBanner: false,
  ));
}

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//     ),
//   };
// }
