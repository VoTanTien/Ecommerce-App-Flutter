import 'package:flutter/material.dart';
import 'package:t_t_project/screens/home.dart';
import 'package:t_t_project/screens/loginscreens/login.dart';
import 'package:t_t_project/screens/loginscreens/start.dart';


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
