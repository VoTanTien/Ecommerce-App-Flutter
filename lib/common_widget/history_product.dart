import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:t_t_project/constants/colors.dart';
import 'package:t_t_project/screens/product_detail.dart';
import 'package:t_t_project/screens/rate.dart';

import '../objects/product.dart';

class HistoryItem extends StatelessWidget{
  final Product product;
  final price;
  final option;
  final quantity;

  const HistoryItem({Key? key, required this.price, required this.option, required this.quantity, required this.product }) : super(key: key) ;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          child: InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => productDetailScreen(product: product)));
            },
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
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: CachedNetworkImage(
                                imageUrl: product.image,
                                placeholder: (context, url) => CircularProgressIndicator(),
                                errorWidget: (context, url, error) => Icon(Icons.error),
                                width: 80,
                                height: 100,
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
                                product.title,
                                style: GoogleFonts.inter(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                'Option: $option',
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
                                    '\$ $price',
                                    style: GoogleFonts.inter(
                                        fontSize: 15,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    ' x $quantity',
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
                      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 17),
                      child: RichText(
                        text: TextSpan(
                            style: GoogleFonts.inter(
                                fontSize: 16, color: Colors.white, fontWeight: FontWeight.w500),
                            children: <TextSpan>[
                              TextSpan(text: 'Amount pay:  '),
                              TextSpan(
                                text:
                                '\$${price * quantity}',
                                style: GoogleFonts.inter(
                                    fontSize: 16,
                                    color: redColor,
                                    fontWeight: FontWeight.w600,
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
          top: 135,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding:
              EdgeInsets.symmetric(vertical: 5, horizontal: 20),
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
        ),
      ],
    );
  }

}