import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FilterButton extends StatelessWidget{
  final String content;
  const FilterButton({Key? key, required this.content}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric( horizontal: 25 ),
        backgroundColor:  Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(color: Colors.grey, width: 1),
        ),
      ),
      onPressed: () {

      },
      child: Text(
        content,
        style: GoogleFonts.inter(
            fontSize: 14,
            color: Colors.grey,
            fontWeight: FontWeight.w500),
      ),
    );
  }

}