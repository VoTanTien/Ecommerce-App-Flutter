import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:t_t_project/constants/colors.dart';

class OptionButton extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onPressed;

  const OptionButton({
    Key? key,
    required this.text,
    required this.isSelected,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        side: BorderSide(
          width: 2,
          color: isSelected ? redColor : greyColor,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text(
        text,
        style: GoogleFonts.inter(
          color: Colors.black,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}