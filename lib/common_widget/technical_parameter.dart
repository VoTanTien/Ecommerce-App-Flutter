import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class Parameters extends StatelessWidget{
  final subtitle;
  final title;
  const Parameters({Key? key, required this.title, required this.subtitle}) : super(key: key) ;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      child: Row(
        children: [
          SizedBox(
            width: size.width * 0.4,
            child: Text(
              title,
              style: GoogleFonts.inter(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Colors.white,),
            ),
          ),
          Expanded(
            child: Text(
              subtitle,
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.white,),
            ),
          ),
        ],
      ),
    );
  }

}