import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:t_t_project/common_widget/cart_item.dart';
import 'package:t_t_project/constants/colors.dart';
import 'package:t_t_project/constants/image_strings.dart';
import 'package:input_quantity/input_quantity.dart';
import 'package:t_t_project/screens/order.dart';

import '../objects/cart_item_data.dart';
import '../services/database_service.dart';


class cartScreen extends StatefulWidget {
  @override
  State<cartScreen> createState() => _cartScreenState();
}

class _cartScreenState extends State<cartScreen> {
  bool isCheckedAll = false;
  List<CartItemData> _cartItems = [];

  @override
  void initState() {
    super.initState();
    _loadCartItems();
  }

  Future<void> _loadCartItems() async {
    final cartItems = await DatabaseService().getCartItems();
    setState(() {
      _cartItems = cartItems;
    });
  }

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
                        onPressed: () async {
                          final checkedCartItems = _cartItems.where((item) => item.cartProduct.isChecked).toList();
                          if (checkedCartItems.isNotEmpty) {
                            try {
                              await DatabaseService().removeCheckedCartItems(checkedCartItems);
                              setState(() {
                                _cartItems.removeWhere((item) => item.cartProduct.isChecked);
                              });
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Error deleting items: $e")),
                              );
                            }

                          }
                        },
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
                height: 480,
                width: double.infinity,
                child: SingleChildScrollView(
                  child: _cartItems.isEmpty
                      ? Center(
                    child: Text(
                    'Your cart is empty',
                    style: GoogleFonts.inter(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w400),
                  ),
                  )
                      : Wrap(
                    spacing: 0,
                    runSpacing: 10,
                    children: _cartItems.map((cartItemData) =>
                    CartItem(
                      cartItemData: cartItemData, // Pass cartItemData
                      onCartItemChecked: (value){
                        setState(() {
                          final allChecked = _cartItems.every((item) => item.cartProduct.isChecked);
                          isCheckedAll = allChecked;
                        });
                      },
                      onQuantityChanged: (newQuantity) {
                        setState(() {
                          cartItemData.cartProduct.quantity = newQuantity;
                          print ('quantity:  ${cartItemData.cartProduct.quantity}');
                          // can update the database here
                          // or in a separate function called from here.
                        });
                      },
                    )).toList(),
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
                                // Update the isChecked property in each cart item AND the _cartItems list
                                for (var i = 0; i < _cartItems.length; i++) {
                                  _cartItems[i].cartProduct.isChecked = isCheckedAll;
                                }
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
                            final checkedCartItems = _cartItems.where((item) => item.cartProduct.isChecked).toList();
                            Navigator.push(context, MaterialPageRoute(builder: (context) => orderScreen(cartItems: checkedCartItems)));
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
