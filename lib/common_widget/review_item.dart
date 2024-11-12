import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:t_t_project/constants/colors.dart';
import 'package:t_t_project/constants/image_strings.dart';

class ReviewItem extends StatelessWidget{
  final initRating;
  final image;
  final title;
  final user;
  const ReviewItem({Key? key, required this.image, required this.user, required this.initRating, required this.title}) : super(key: key) ;
  @override
  Widget build(BuildContext context) {
    var avatars = AssetImage(avatar);
    return Card(
      color: lightgreyColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15), side: BorderSide(color: Colors.white, width: 1),),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(100),
              ),
              height: 50,
              width: 50,
              child: Image(
                  image: avatars,
              ),
            ),
            Text(
              '@$user',
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,),
            ),
            RatingBar(
              itemSize: 14,
              minRating: 1,
              maxRating: 5,
              initialRating: initRating,
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
              '$title',
              style: GoogleFonts.inter(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Colors.white,),
            ),
            if (image != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: CachedNetworkImage(
                  imageUrl: image,
                  placeholder: (context, url) => CircularProgressIndicator(), // Widget to show while loading
                  errorWidget: (context, url, error) => Icon(Icons.error), // Widget to show if an error occurs
                  width: 80,
                  height: 100,
                  fit: BoxFit.cover,
                )
              ),
          ],
        ),
      ),
    );
  }

}