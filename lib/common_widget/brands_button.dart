import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:t_t_project/constants/image_strings.dart';

class brandsButton extends StatelessWidget{
  final brand;
  const brandsButton({Key? key, required this.brand}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
      },
      child: Image(
        image: brand,
        height: 70,
        width: 100,
      ),
    );
  }

}