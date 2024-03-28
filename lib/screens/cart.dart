import 'package:flutter/material.dart';
import 'package:t_t_project/constants/colors.dart';

class cartScreen extends StatefulWidget{
  @override
  State<cartScreen> createState() => _cartScreenState();
}

class _cartScreenState extends State<cartScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: blackColor,
        body: Text('Cart', style: TextStyle(color: Colors.white),),
      ),
    );
  }
}