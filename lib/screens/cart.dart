import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:t_t_project/common_widget/cart_item.dart';
import 'package:t_t_project/constants/colors.dart';
import 'package:t_t_project/constants/image_strings.dart';
import 'package:input_quantity/input_quantity.dart';
import 'package:t_t_project/objects/product_manager.dart';
import 'package:t_t_project/screens/order.dart';


class cartScreen extends StatefulWidget {
  @override
  State<cartScreen> createState() => _cartScreenState();
}

class _cartScreenState extends State<cartScreen> {
  bool isCheckedAll = false;
  ProductManager productManager = ProductManager();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: blackColor,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  'My Cart',
                  style: GoogleFonts.inter(
                      fontSize: 26,
                      color: Colors.white,
                      fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SizedBox(width: 5,),
                      Icon(
                        Icons.list_alt_outlined,
                        color: Colors.white,
                        size: 25,
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Text(
                        'Item List',
                        style: GoogleFonts.inter(
                            fontSize: 22,
                            color: Colors.white,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.delete_outline),
                        color: Colors.white,
                        iconSize: 30,
                      ),
                      SizedBox(width: 20),
                    ],
                  ),
                ],
              ),
              Container(
                height: 520,
                width: double.infinity,
                child: SingleChildScrollView(
                  child: Wrap(
                    spacing: 0,
                    runSpacing: 10,
                    children: productManager.products.take(3).map((e) {
                      return CartItem(
                          subimage: e.image,
                          price: e.discountPrice ?? e.price,
                          option: e.option,
                          title: e.title,
                          quantity: e.quantity);
                    }).toList()
                  ),
                ),
              ),
              Divider(
                color: Colors.white,
                thickness: 2,
                height: 30,
              ), 
              Container(
                padding: EdgeInsets.all(10),
                width: double.infinity,
                height: 60,
                decoration: BoxDecoration(shape: BoxShape.rectangle, borderRadius: BorderRadius.circular(12), color: Colors.white),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Checkbox(
                            value: isCheckedAll,
                            side: BorderSide(color: greyColor, width: 2),
                            activeColor: Colors.red,
                            onChanged: (val) {
                              setState(() {
                                isCheckedAll = val!;
                              });
                            }),
                        Text(
                          'Select All',
                          style: GoogleFonts.inter(
                              fontSize: 12,
                              color: greyColor,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        // Column(
                        //   children: [
                        //     Text(
                        //       'Total Price:',
                        //       style: GoogleFonts.inter(
                        //           fontSize: 12,
                        //           color: greyColor,
                        //           fontWeight: FontWeight.w500),
                        //     ),
                        //     Text(
                        //       '\$ 1000',
                        //       style: GoogleFonts.inter(
                        //           fontSize: 15,
                        //           color: redColor,
                        //           fontWeight: FontWeight.w600),
                        //     ),
                        //   ],
                        // ),
                        SizedBox(width: 10,),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                            backgroundColor: redColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => orderScreen()));
                          },
                          child: Text(
                            'Buy now',
                            style: GoogleFonts.inter(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
