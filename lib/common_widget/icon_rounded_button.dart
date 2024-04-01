import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:t_t_project/constants/colors.dart';

class iconRoundedButton extends StatelessWidget {
  final icon;
  const iconRoundedButton({Key? key, required this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
      ),
      padding: EdgeInsets.all(15),
      child: Icon(
        icon,
        color: blackColor,
        size: 26,
      ),
    );
  }
}
