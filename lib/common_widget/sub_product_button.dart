import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:t_t_project/constants/colors.dart';
import 'package:t_t_project/constants/image_strings.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:t_t_project/screens/product_detail.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../objects/product.dart';

class SubProductButton extends StatelessWidget {
  final subimage;
  final title;
  final price;
  final rating;
  final discountPrice ;
  final Product product;
  const SubProductButton({Key? key, required this.subimage, required this.title, required this.price, required this.rating, this.discountPrice, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.5 - 25,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(16)),
      padding: EdgeInsets.all(10),
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => productDetailScreen(product: product)));
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: CachedNetworkImage(
                imageUrl: subimage,
                placeholder: (context, url) => CircularProgressIndicator(), // Widget to show while loading
                errorWidget: (context, url, error) => Icon(Icons.error), // Widget to show if an error occurs
                width: 200,
                height: 150,
                fit: BoxFit.cover,
              )
            ),
            Text(
              title,
              style: GoogleFonts.inter(
                  fontSize: 16, color: blackColor, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 5,
            ),
            RatingBar(
              itemSize: 20,
              minRating: 1,
              maxRating: 5,
              initialRating: rating,
              allowHalfRating: true,
              ignoreGestures: true,
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
            SizedBox(
              height: 5,
            ),
            discountPrice == null ?
                Text(
                  '\$$price',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                  ),
                )
            :
            Row(
              children: [
                Text(
                  '\$$price',
                  style: GoogleFonts.inter(
                      fontSize: 16,
                      color: Colors.grey,
                      fontWeight: FontWeight.w700,
                    decoration: TextDecoration.lineThrough
                  ),
                ),
                Text(
                  '  \$$discountPrice',
                  style: GoogleFonts.inter(
                      fontSize: 16,
                      color: redColor,
                      fontWeight: FontWeight.w700),
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}
