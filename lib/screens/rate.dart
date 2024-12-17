import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:t_t_project/constants/colors.dart';
import 'package:t_t_project/services/database_service.dart';
import 'package:image_picker/image_picker.dart';

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
  late ImagePicker imagePicker;
  File? image;

  @override
  void initState() {
    super.initState();
    imagePicker = ImagePicker();
  }

  chooseImage() async {
    XFile? selectedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);
    if (selectedImage != null) {
      image = File(selectedImage.path);
      setState(() {
        image;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
                width: image == null ? 90: size.width/2,
                height: image == null ? 70: size.height/3,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    backgroundColor: blackColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    side: BorderSide(color: Colors.white, width: 2),
                  ),
                  onPressed: () {
                    chooseImage();
                  },
                  child: image == null
                      ? Icon(
                          Icons.camera_alt_rounded,
                          color: Colors.white,
                          size: 30,
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.file(
                            image!,
                            // fit: BoxFit.cover,
                          ),
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
                    String? imageUrl;
                    if (image != null) {
                      imageUrl = await DatabaseService().uploadImageToStorage(image!);
                    }
                    try {
                      await DatabaseService().addComment(
                          detailController.text, widget.product.id, rating, imageUrl ?? '',);
                    } catch (e) {
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
