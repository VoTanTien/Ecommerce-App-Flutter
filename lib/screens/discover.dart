import 'package:carousel_slider/carousel_slider.dart'as slider_controller;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:t_t_project/common_widget/brands_button.dart';
import 'package:t_t_project/common_widget/icon_rounded_button.dart';
import 'package:t_t_project/common_widget/sub_product_button.dart';
import 'package:t_t_project/constants/colors.dart';
import 'package:t_t_project/constants/image_strings.dart';

import '../objects/category.dart';
import '../objects/product.dart';
import '../services/database_service.dart';

class discoverScreen extends StatefulWidget {
  @override
  State<discoverScreen> createState() => _discoverScreenState();
}

class _discoverScreenState extends State<discoverScreen> {
  final myimages = [
    Image.asset(bgn5),
    Image.asset(bgn4),
    Image.asset(bgn3),
    Image.asset(ltbg3),
  ];
  int myCurrentIndex = 0;


  final DatabaseService _databaseService = DatabaseService();
  List<Product> _products = [];
  List<Category> _categorys = [];

  @override
  void initState() {
    super.initState();
    _loadProducts();
    _loadCategory();
  }

  Future<void> _loadProducts() async {
    final products = await _databaseService.getProducts();
    setState(() {
      _products = products;
    });
  }

  Future<void> _loadCategory() async {
    final categorys = await _databaseService.getCategory();
    setState(() {
      _categorys = categorys;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: blackColor,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Discover Your Best',
                    style: GoogleFonts.inter(
                        fontSize: 34,
                        color: Colors.white,
                        fontWeight: FontWeight.w500)),
                SizedBox(
                  height: 10,
                ),
                slider_controller.CarouselSlider(
                  items: myimages,
                  options: slider_controller.CarouselOptions(
                      height: 185,
                      autoPlay: true,
                      autoPlayCurve: Curves.fastOutSlowIn,
                      autoPlayAnimationDuration: Duration(milliseconds: 900),
                      autoPlayInterval: Duration(seconds: 5),
                      enlargeCenterPage: true,
                      aspectRatio: 2.0,
                      onPageChanged: (index, reason) {
                        setState(() {
                          myCurrentIndex = index;
                        });
                      }),
                ),
                SizedBox(
                  height: 15,
                ),
                Align(
                  alignment: Alignment.center,
                  child: AnimatedSmoothIndicator(
                    activeIndex: myCurrentIndex,
                    count: myimages.length,
                    effect: WormEffect(
                      dotColor: CupertinoColors.systemGrey6,
                      activeDotColor: redColor,
                      dotHeight: 8,
                      dotWidth: 8,
                      spacing: 10,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                // Text(
                //   'Product Type',
                //   style: GoogleFonts.inter(
                //       fontSize: 22,
                //       color: Colors.white,
                //       fontWeight: FontWeight.w500),
                // ),
                // SizedBox(
                //   height: 10,
                // ),
                // SizedBox(
                //   width: double.infinity,
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       Column(
                //         children: [
                //           iconRoundedButton(
                //             icon: Icons.laptop_chromebook_outlined,
                //           ),
                //           SizedBox(height: 5,),
                //           Text(
                //             'Laptop',
                //             style: GoogleFonts.inter(
                //               fontSize: 14,
                //               color: Colors.white,
                //               fontWeight: FontWeight.w500,
                //             ),
                //           ),
                //         ],
                //       ),
                //       Column(
                //         children: [
                //           iconRoundedButton(
                //             icon: Icons.headset_outlined,
                //           ),
                //           SizedBox(height: 5,),
                //           Text(
                //             'Headphone',
                //             style: GoogleFonts.inter(
                //               fontSize: 14,
                //               color: Colors.white,
                //               fontWeight: FontWeight.w500,
                //             ),
                //           ),
                //         ],
                //       ),
                //       Column(
                //         children: [
                //           iconRoundedButton(
                //             icon: Icons.mouse_outlined,
                //           ),
                //           SizedBox(height: 5,),
                //           Text(
                //             'Mouse',
                //             style: GoogleFonts.inter(
                //               fontSize: 14,
                //               color: Colors.white,
                //               fontWeight: FontWeight.w500,
                //             ),
                //           ),
                //         ],
                //       ),
                //       Column(
                //         children: [
                //           iconRoundedButton(
                //             icon: Icons.keyboard_alt_outlined,
                //           ),
                //           SizedBox(height: 5,),
                //           Text(
                //             'Keyboard',
                //             style: GoogleFonts.inter(
                //               fontSize: 14,
                //               color: Colors.white,
                //               fontWeight: FontWeight.w500,
                //             ),
                //           ),
                //         ],
                //       ),
                //       Column(
                //         children: [
                //           iconRoundedButton(
                //             icon: Icons.gamepad_outlined,
                //           ),
                //           SizedBox(height: 5,),
                //           Text(
                //             'Gamepad',
                //             style: GoogleFonts.inter(
                //               fontSize: 14,
                //               color: Colors.white,
                //               fontWeight: FontWeight.w500,
                //             ),
                //           ),
                //         ],
                //       ),
                //     ],
                //   ),
                // ),
                // SizedBox(
                //   height: 15,
                // ),
                Text(
                  'Product Size',
                  style: GoogleFonts.inter(
                      fontSize: 22,
                      color: Colors.white,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 50,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _categorys.length,
                    itemBuilder: (context, index) {
                      final category = _categorys[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: brandsButton(size: category.title),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Newest Products',
                  style: GoogleFonts.inter(
                      fontSize: 22,
                      color: Colors.white,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 10,
                ),
                Wrap(
                  spacing: 15,
                  runSpacing: 20,
                  children: _products.reversed
                      .map((product) => // product is now a Product object
                          SubProductButton(
                            subimage: product.image,
                            // Access properties directly
                            title: product.title,
                            rating: product.rate,
                            price: product.price,
                            discountPrice: product.discountPrice,
                            product: product, // Pass the Product object
                          ))
                      .toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
