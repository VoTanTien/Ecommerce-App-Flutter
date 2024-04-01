import 'package:carousel_slider/carousel_slider.dart';
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

class discoverScreen extends StatefulWidget {
  @override
  State<discoverScreen> createState() => _discoverScreenState();
}

class _discoverScreenState extends State<discoverScreen> {
  final myimages = [
    Image.asset(lt0),
    Image.asset(ltbg1),
    Image.asset(ltbg2),
    Image.asset(ltbg3),
  ];
  int myCurrentIndex = 0;

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
                  CarouselSlider(
                    items: myimages,
                    options: CarouselOptions(
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
                  Text(
                    'Product Type',
                    style: GoogleFonts.inter(
                        fontSize: 22,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            iconRoundedButton(
                              icon: Icons.laptop_chromebook_outlined,
                            ),
                            SizedBox(height: 5,),
                            Text(
                              'Laptop',
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            iconRoundedButton(
                              icon: Icons.headset_outlined,
                            ),
                            SizedBox(height: 5,),
                            Text(
                              'Headphone',
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            iconRoundedButton(
                              icon: Icons.mouse_outlined,
                            ),
                            SizedBox(height: 5,),
                            Text(
                              'Mouse',
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            iconRoundedButton(
                              icon: Icons.keyboard_alt_outlined,
                            ),
                            SizedBox(height: 5,),
                            Text(
                              'Keyboard',
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            iconRoundedButton(
                              icon: Icons.gamepad_outlined,
                            ),
                            SizedBox(height: 5,),
                            Text(
                              'Gamepad',
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Product Brand',
                    style: GoogleFonts.inter(
                        fontSize: 22,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        brandsButton(
                          brand: AssetImage(asus),
                        ),
                        SizedBox(width: 15,),
                        brandsButton(
                          brand: AssetImage(msi),
                        ),
                        SizedBox(width: 15,),
                        brandsButton(
                          brand: AssetImage(apple),
                        ),
                        SizedBox(width: 15,),
                        brandsButton(
                          brand: AssetImage(acer),
                        ),
                        SizedBox(width: 15,),
                        brandsButton(
                          brand: AssetImage(logitech),
                        ),
                      ],
                    ),
                  ),
            
                  Text(
                    'Popular Products',
                    style: GoogleFonts.inter(
                        fontSize: 22,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 10,),
                  Wrap(
                    spacing: 15,
                    runSpacing: 20,
                    children: List.generate(6, (index) => SubProductButton(
                      subimage: AssetImage(lt1s),
                      title: 'Laptop ASUS Vivobook 15 X1502ZA BQ127W',
                      rating: 4,
                      price: 1000,
                      discountPrice: 999,
                    ),
                    ),
                  ),

                ],
              ),
            ),
          ),
      ),
    );
  }
}
