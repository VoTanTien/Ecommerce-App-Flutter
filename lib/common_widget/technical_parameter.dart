import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Parameters extends StatelessWidget{
  final subtitle;
  final title;
  const Parameters({Key? key, required this.title, required this.subtitle}) : super(key: key) ;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 130,
          child: Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Colors.white,),
          ),
        ),
        SizedBox(
          width: 220,
          child: Text(
            subtitle,
            style: GoogleFonts.inter(
              fontSize: 14,
              color: Colors.white,),
          ),
        ),
      ],
    );
  }

}