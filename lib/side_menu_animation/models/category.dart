import 'package:flutter/widgets.dart';
import 'package:flutter_challenges/side_menu_animation/models/subcategory.dart';

class Category {
  String name;
  IconData icon;
  List<Subcategory> subcategories;

  Category({required this.name, required this.subcategories, required this.icon});
}