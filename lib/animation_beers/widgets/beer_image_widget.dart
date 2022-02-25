import 'package:flutter/material.dart';
import 'package:flutter_challenges/animation_beers/models/beer.dart';

class BeerImage extends StatelessWidget {
  const BeerImage({
    Key? key,
    required this.beer,
  }) : super(key: key);

  final Beer beer;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          right: 0,
          top: 0,
          bottom: 0,
          child: Opacity(
              child: Image.asset(beer.img, color: Colors.black), opacity: 0.2),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Image.asset(beer.img),
        )
      ],
    );
  }
}
