import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:t_t_project/common_widget/assessment_product.dart';
import 'package:t_t_project/constants/colors.dart';
import 'package:t_t_project/screens/rate.dart';

class  CardProductItem extends StatelessWidget{
  final subimage;
  final title;
  final price;
  final option;
  const CardProductItem({Key? key, required this.subimage, required this.price, required this.option, required this.title}) : super(key: key) ;
  @override
  Widget build(BuildContext context) {
    return Column(
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
                children: [
                  Text(
                    title,
                    style: GoogleFonts.inter(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    'Color: $option',
                    style: GoogleFonts.inter(
                        fontSize: 13,
                        color: Color(0xFFA0A0A0),
                        fontWeight: FontWeight.w400),
                  ),
                  Text(
                    '\$ $price',
                    style: GoogleFonts.inter(
                        fontSize: 15,
                        color: redColor,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ],
        ),

      ],
    );
  }

}