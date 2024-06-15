import 'package:flutter/cupertino.dart';

class Comment {
  String name;
  double rate;
  String title;
  AssetImage? image;

  Comment(this.name, this.rate, this.title, this.image);
}