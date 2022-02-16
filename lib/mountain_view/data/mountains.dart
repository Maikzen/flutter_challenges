import 'package:flutter/material.dart';
import 'package:flutter_challenges/mountain_view/models/mountain.dart';
import 'package:flutter_challenges/mountain_view/resources/strings.dart' as strings;

List<Mountain> listMountains = [
  Mountain(
      'Everest',
      'assets/img/everest.jpg',
      'assets/img/everest_blank.png',
      strings.descEverest,
      Colors.lightBlueAccent,
      '8.849 m',
      'Nepal; China; Tíbet'),
  Mountain('K2', 'assets/img/k2.jpg', 'assets/img/k2_blank.png',
      strings.descK2, Colors.blueAccent, '8.611 m', 'Asia'),
  Mountain(
      'Monte Fuji',
      'assets/img/monte_fuji.jpg',
      'assets/img/monte_fuji_blank.png',
      strings.descMountFuji,
      Colors.deepOrangeAccent,
      '3.776 m',
      'Isla de Honshu; Japon'),
];