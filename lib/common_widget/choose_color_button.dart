import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:t_t_project/constants/colors.dart';

class ColorButton extends StatelessWidget {
  final String colorName;
  final bool isSelected;
  final VoidCallback onPressed;

  const ColorButton({
    Key? key,
    required this.colorName,
    required this.isSelected,
    required this.onPressed,
  }) : super(key: key);

  Color _getColorFromString(String colorName) {
    switch (colorName.toLowerCase()) {
      case 'red':
        return Colors.red;
      case 'blue':
        return Colors.blue;
      case 'green':
        return Colors.green;
      case 'yellow':
        return Colors.yellow;
      case 'brown':
        return Colors.brown;

      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = _getColorFromString(colorName);
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        side: BorderSide(
          width: 2,
          color: isSelected ? redColor : greyColor,
        ),
        padding: const EdgeInsets.all(6),
        shape: CircleBorder(),
      ),
      child: CircleAvatar(
        backgroundColor: color,
        radius: 12,
      ),
    );
  }
}