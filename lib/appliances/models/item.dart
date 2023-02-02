import 'package:flutter/material.dart';

class Item {
  int id;
  String name;
  String? subtitle;
  String image;
  Color color;

  Item(
      {required this.id,
      required this.name,
      this.subtitle,
      required this.image,
      required this.color});
}