import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:t_t_project/constants/colors.dart';

class discoverScreen extends StatefulWidget{
  @override
  State<discoverScreen> createState() => _discoverScreenState();
}

class _discoverScreenState extends State<discoverScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: blackColor,
        body: Text('discover', style: TextStyle(color: Colors.white),),
      ),
    );
  }
}