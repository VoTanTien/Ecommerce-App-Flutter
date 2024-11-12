import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:t_t_project/constants/colors.dart';

import '../objects/cart_item_data.dart';

class OrderItem extends StatelessWidget{
  final CartItemData cartItemData;

  const OrderItem({Key? key, required this.cartItemData, }) : super(key: key) ;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: greyColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: CachedNetworkImage(
                      imageUrl: cartItemData.product.image,
                      placeholder: (context, url) => CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                      width: 80,
                      height: 90,
                      fit: BoxFit.cover,
                    )),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      cartItemData.product.title,
                      style: GoogleFonts.inter(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                        'option: ${cartItemData.cartProduct.option}',
                      style: GoogleFonts.inter(
                          fontSize: 13,
                          color: Color(0xFFA0A0A0),
                          fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Text(
                          '\$ ${cartItemData.product.discountPrice ?? cartItemData.product.price}',
                          style: GoogleFonts.inter(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          '  x ${cartItemData.cartProduct.quantity}',
                          style: GoogleFonts.inter(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

}