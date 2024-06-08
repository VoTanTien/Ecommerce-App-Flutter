import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:t_t_project/constants/colors.dart';

class HistoryItem extends StatelessWidget{
  final subimage;
  final title;
  final price;
  final option;
  final quantity;
  final pay;

  const HistoryItem({Key? key, required this.subimage, required this.price, required this.option, required this.title, required this.quantity, required this.pay }) : super(key: key) ;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          child: InkWell(
            onTap: (){},
            child: Card(
              color: greyColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
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
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '\$ $price',
                                    style: GoogleFonts.inter(
                                        fontSize: 14,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    'x$quantity',
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
                    Padding(
                      padding: const EdgeInsets.fromLTRB(17, 0, 0, 0),
                      child: Divider(color: Colors.white, height: 10, thickness: 2,),

                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 17),
                      child: RichText(
                        text: TextSpan(
                            style: GoogleFonts.inter(
                                fontSize: 16, color: Colors.white, fontWeight: FontWeight.w500),
                            children: <TextSpan>[
                              TextSpan(text: 'Amount pay:  '),
                              TextSpan(
                                text:
                                '\$$pay',
                                style: GoogleFonts.inter(
                                    fontSize: 16,
                                    color: redColor,
                                    fontWeight: FontWeight.w500,
                                ),
                              ),
                            ]
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Positioned(
          right: 25,
          top: 130,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding:
              EdgeInsets.symmetric(vertical: 5, horizontal: 30),
              backgroundColor: redColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () {
            },
            child: Text(
              'Buy back',
              style: GoogleFonts.inter(
                  fontSize: 14,
                  color: Colors.white,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ],
    );
  }

}