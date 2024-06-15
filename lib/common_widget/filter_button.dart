import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:t_t_project/constants/colors.dart';

class FilterButton extends StatefulWidget{
  final String content;
  FilterButton({super.key, required this.content});

  @override
  State<FilterButton> createState() => _FilterButtonState();
}

class _FilterButtonState extends State<FilterButton> {
  bool isClicked = false;

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      padding: EdgeInsets.symmetric( horizontal: 25 ),
      label: Text(
        widget.content,
        style: GoogleFonts.inter(
            fontSize: 14,
            color: Colors.black,
            fontWeight: FontWeight.w600),
      ),
      side: BorderSide(color: greyColor, width: 1),
      selectedColor: redColor,
      disabledColor: Colors.white,
      selected: isClicked,
      onSelected: (val){
        setState(() {
          isClicked = val;
        });
      },
    );



    //   ElevatedButton(
    //   style: ElevatedButton.styleFrom(
    //     padding: EdgeInsets.symmetric( horizontal: 25 ),
    //     backgroundColor:  Colors.white,
    //     shape: RoundedRectangleBorder(
    //       borderRadius: BorderRadius.circular(8),
    //       side: BorderSide(color: greyColor, width: 1),
    //     ),
    //   ),
    //   onPressed: () {
    //     setState(() {
    //       isClicked = !isClicked;
    //     });
    //   },
    //   child: Text(
    //     widget.content,
    //     style: GoogleFonts.inter(
    //         fontSize: 14,
    //         color: greyColor,
    //         fontWeight: FontWeight.w500),
    //   ),
    // );

  }
}