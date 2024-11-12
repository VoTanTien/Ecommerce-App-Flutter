import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:t_t_project/constants/colors.dart';

class OrderItem extends StatelessWidget{
  final subimage;
  final title;
  final price;
  final option;
  final quantity;

  const OrderItem({Key? key, required this.subimage, required this.price, required this.option, required this.title, required this.quantity, }) : super(key: key) ;
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
              Image(
                image: subimage,
                width: 110,
                height: 110,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.inter(
                          fontSize: 13,
                          color: Colors.white,
                          fontWeight: FontWeight.w400),
                    ),
                    Text(
                        'Color: $option',
                      style: GoogleFonts.inter(
                          fontSize: 12,
                          color: Color(0xFFA0A0A0),
                          fontWeight: FontWeight.w400),
                    ),
                    Row(
                      children: [
                        Text(
                          '\$ $price',
                          style: GoogleFonts.inter(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          '    x $quantity',
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