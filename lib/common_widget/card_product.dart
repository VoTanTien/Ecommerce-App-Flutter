import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:t_t_project/common_widget/assessment_item.dart';
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
            Padding(
              padding:
              EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: CachedNetworkImage(
                    imageUrl: subimage,
                    placeholder: (context, url) =>
                        CircularProgressIndicator(),
                    // Widget to show while loading
                    errorWidget: (context, url, error) =>
                        Icon(Icons.error),
                    // Widget to show if an error occurs
                    width: 80,
                    height: 90,
                    fit: BoxFit.cover,
                  )),
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
                    'Accessory colors: $option',
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