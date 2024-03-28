import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:t_t_project/constants/colors.dart';

class searchScreen extends StatefulWidget{
  @override
  State<searchScreen> createState() => _searchScreenState();
}

class _searchScreenState extends State<searchScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: blackColor,
        body: Text('Search', style: TextStyle(color: Colors.white),),
      ),
    );
  }
}