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
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp( MaterialApp(
    home: SafeArea(
      child: startScreen(),
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
