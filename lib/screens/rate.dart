import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:t_t_project/constants/colors.dart';
import 'package:t_t_project/services/database_service.dart';

import '../objects/product.dart';

class rateScreen extends StatefulWidget {
  final Product product;

  const rateScreen({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  State<rateScreen> createState() => _rateScreenState();
}

class _rateScreenState extends State<rateScreen> {
  double rating = 0;

  final detailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: blackColor,
        appBar: AppBar(
          title: Text('Rate Product',
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
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
          child: Column(
            children: [
              Text(
                'Your rating will be displayed in the product\'s reviews',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                    fontSize: 16, color: Colors.white, textStyle: TextStyle()),
              ),
              SizedBox(
                height: 20,
              ),
              RatingBar(
                itemSize: 45,
                minRating: 1,
                maxRating: 5,
                initialRating: 0,
                allowHalfRating: true,
                onRatingUpdate: (i) {
                  setState(() {
                    rating = i;
                  });
                },
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
                height: 20,
              ),
              SizedBox(
                width: 90,
                height: 70,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    backgroundColor: blackColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    side: BorderSide(color: Colors.white, width: 2),
                  ),
                  onPressed: () {},
                  child: Icon(
                    Icons.camera_alt_rounded,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: detailController,
                cursorColor: Colors.white,
                maxLines: 8,
                style: TextStyle(fontSize: 16, color: Colors.white),
                decoration: InputDecoration(
                  hintStyle: TextStyle(color: Colors.white, fontSize: 16),
                  hintText: 'Please share what you like about this product',
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Colors.white),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 1),
                      borderRadius: BorderRadius.circular(15)),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: redColor,
                    padding: EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  onPressed: () async {
                    try{
                      await DatabaseService().addComment(
                          detailController.text,
                          widget.product.id,
                          rating,
                          '');
                    } catch (e){
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Error send comment: $e')),
                      );
                    }
                  },
                  child: Text(
                    'Send',
                    style: GoogleFonts.inter(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
