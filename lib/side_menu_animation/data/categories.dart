import 'package:flutter/material.dart';
import 'package:flutter_challenges/side_menu_animation/models/category.dart';
import 'package:flutter_challenges/side_menu_animation/models/subcategory.dart';

List<Category> categories = [
  Category(
    name: 'Films',
    icon: Icons.account_tree_sharp,
    subcategories: [
      Subcategory(name: 'Western', color: Colors.blue, icon: Icons.ac_unit),
      Subcategory(name: 'Fantasy', color: Colors.green, icon: Icons.ac_unit),
      Subcategory(name: 'Horror', color: Colors.purple, icon: Icons.ac_unit),
    ],
  ),
  Category(
    name: 'Music',
    icon: Icons.add_a_photo_outlined,
    subcategories: [
      Subcategory(name: 'Jazz', color: Colors.yellow, icon: Icons.ac_unit),
      Subcategory(name: 'Rock concerts', color: Colors.orange, icon: Icons.ac_unit),
      Subcategory(name: 'Pop', color: Colors.green, icon: Icons.ac_unit),
    ],
  ),
  Category(
    name: 'Films',
    icon: Icons.account_tree_sharp,
    subcategories: [
      Subcategory(name: 'Western', color: Colors.blue, icon: Icons.ac_unit),
      Subcategory(name: 'Fantasy', color: Colors.green, icon: Icons.ac_unit),
      Subcategory(name: 'Horror', color: Colors.purple, icon: Icons.ac_unit),
    ],
  ),
  Category(
    name: 'Music',
    icon: Icons.airline_seat_flat_angled_rounded,
    subcategories: [
      Subcategory(name: 'Jazz', color: Colors.yellow, icon: Icons.ac_unit),
      Subcategory(name: 'Rock concerts', color: Colors.orange, icon: Icons.ac_unit),
      Subcategory(name: 'Pop', color: Colors.green, icon: Icons.ac_unit),
    ],
  ),
];
