import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:t_t_project/constants/colors.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:t_t_project/screens/discover.dart';
import 'package:t_t_project/screens/profile.dart';
import 'package:t_t_project/screens/search.dart';
import 'package:t_t_project/screens/cart.dart';

class homeScreen extends StatefulWidget {
  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  int index = 0;
  final screens = [
    discoverScreen(),
    searchScreen(),
    cartScreen(),
    profileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: blackColor,
         body: screens[index],
         bottomNavigationBar: CurvedNavigationBar(
           backgroundColor: blackColor,
           color: redColor,
           height: 60,
           animationDuration: Duration(milliseconds: 450),
           index: index,
           items: [
             CurvedNavigationBarItem(
               child: Icon(Icons.home, color: Colors.white, size: 25,),
             ),
             CurvedNavigationBarItem(
               child: Icon(Icons.search, color: Colors.white,size: 27,),
             ),
             CurvedNavigationBarItem(
               child: Icon(Icons.shopping_cart, color: Colors.white,size: 25,),
             ),
             CurvedNavigationBarItem(
               child: Icon(Icons.person, color: Colors.white,size: 25,),
             ),
           ],
           onTap: (index) => setState(() => this.index = index ),
         ),
      ),
    );
  }
}
