import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:t_t_project/common_widget/sub_product_button.dart';
import 'package:t_t_project/constants/colors.dart';
import 'package:t_t_project/constants/image_strings.dart';

class likedScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Liked Product',
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
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Wrap(
              spacing: 15,
              runSpacing: 10,
              children: List.generate(6, (index) => SubProductButton(
                subimage: AssetImage(lt1s),
                title: 'Laptop ASUS Vivobook 15 X1502ZA BQ127W',
                rating: 4,
                price: 1000,
                discountPrice: 999,
              ),
              ),
            ),
          ),
        ),
      ),
    );
  }

}