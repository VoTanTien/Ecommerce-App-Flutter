import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:t_t_project/common_widget/assessment_product.dart';
import 'package:t_t_project/constants/colors.dart';
import 'package:t_t_project/screens/rate.dart';

class AssessmentItem extends StatelessWidget{
  final subimage;
  final title;
  final price;
  final option;
  const AssessmentItem({Key? key, required this.subimage, required this.price, required this.option, required this.title}) : super(key: key) ;
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
                    Text(
                      '\$ $price',
                      style: GoogleFonts.inter(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 0, horizontal: 15),
            child: Divider(color: Colors.white, height: 0, thickness: 2,),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: 10,),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding:
                    EdgeInsets.symmetric(vertical: 5, horizontal: 30),
                    backgroundColor: redColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => rateScreen()));
                  },
                  child: Text(
                    'Rate product',
                    style: GoogleFonts.inter(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
  
}