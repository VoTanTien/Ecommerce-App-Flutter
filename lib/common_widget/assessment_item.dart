import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:t_t_project/common_widget/assessment_item.dart';
import 'package:t_t_project/constants/colors.dart';
import 'package:t_t_project/objects/assessment_item_data.dart';
import 'package:t_t_project/screens/rate.dart';

import '../constants/image_strings.dart';
import '../objects/product.dart';

class AssessmentItem extends StatelessWidget {
  final AssessmentItemData assessment;

  const AssessmentItem({Key? key, required this.assessment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var avatars = AssetImage(avatar);
    return Card(
      color: greyColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
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
                      imageUrl: assessment.product.image,
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    )),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      assessment.product.title,
                      style: GoogleFonts.inter(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      'Color: ${assessment.product.option}',
                      style: GoogleFonts.inter(
                          fontSize: 12,
                          color: Color(0xFFA0A0A0),
                          fontWeight: FontWeight.w400),
                    ),
                    // Text(
                    //   '\$ ${assessment.product.discountPrice ?? assessment.product.price}',
                    //   style: GoogleFonts.inter(
                    //       fontSize: 14,
                    //       color: Colors.white,
                    //       fontWeight: FontWeight.w600),
                    // ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 0, horizontal: 15),
            child: Divider(
              color: Colors.white,
              height: 0,
              thickness: 2,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      height: 40,
                      width: 40,
                      child: Image(
                        image: avatars,
                      ),
                    ),
                    SizedBox(width: 10,),
                    Column(
                      children: [
                        Text(
                          '@${assessment.comment.userName}',
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        RatingBar(
                          itemSize: 14,
                          minRating: 1,
                          maxRating: 5,
                          initialRating: assessment.comment.rate,
                          allowHalfRating: true,
                          onRatingUpdate: (i) {},
                          ratingWidget: RatingWidget(
                            full: Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            half: Icon(
                              Icons.star_border_outlined,
                              color: Colors.amber,
                            ),
                            empty: Icon(
                              Icons.star_border_outlined,
                              color: Colors.amber,
                            ),
                          ),
                        ),
                        Text(
                          assessment.comment.title,
                          style: GoogleFonts.inter(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(width: 60,),
                    if (assessment.comment.image != null)
                      ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: CachedNetworkImage(
                            imageUrl: assessment.comment.image ?? '' ,
                            placeholder: (context, url) => CircularProgressIndicator(), // Widget to show while loading
                            errorWidget: (context, url, error) => Icon(Icons.error), // Widget to show if an error occurs
                            width: 80,
                            height: 100,
                            fit: BoxFit.cover,
                          )
                      ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}


