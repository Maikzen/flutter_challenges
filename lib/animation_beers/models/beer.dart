import 'package:flutter/material.dart';

class Beer {
  String id;
  String name;
  String desc;
  double price;
  String img;
  Color color;

  Beer(
      {required this.id,
      required this.name,
      required this.desc,
      required this.price,
      required this.img,
      required this.color});
}
