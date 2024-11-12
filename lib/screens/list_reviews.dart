import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:t_t_project/common_widget/review_item.dart';
import 'package:t_t_project/constants/colors.dart';
import 'package:t_t_project/objects/comment.dart';
import 'package:t_t_project/screens/product_detail.dart';

import '../constants/image_strings.dart';

class reviewScreen extends StatelessWidget {
  final double averageRating ;
  final int countReview ;
  final List<CommentData> comments;
  const reviewScreen({Key? key, required this.comments, required this.averageRating, required this.countReview,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Reviews',
              style: GoogleFonts.inter(
                  fontSize: 26,
                  color: Colors.white,
                  fontWeight: FontWeight.w500)),
          centerTitle: true,
          backgroundColor: blackColor,
          leading: BackButton(
            color: Colors.white,
          ),
        ),
        body: Container(
          color: blackColor,
          height: double.infinity,
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      '${averageRating.toStringAsFixed(1)} / 5.0 ',
                      style: GoogleFonts.inter(
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    RatingBar(
                      itemSize: 20,
                      minRating: 1,
                      maxRating: 5,
                      initialRating: averageRating,
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
                      '  ($countReview Reviews)',
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                Wrap(
                    spacing: 0,
                    runSpacing: 5,
                    children: comments.map(
                          (e) => ReviewItem(
                        user: e.userName, // Access the correct userName field
                        initRating: e.rate,
                        title: e.title,
                        image: e.image,
                      ),
                    )
                        .toList()
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
