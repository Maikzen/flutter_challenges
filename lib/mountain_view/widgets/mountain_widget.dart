import 'package:flutter/material.dart';
import 'package:flutter_challenges/mountain_view/models/mountain.dart';

class MountainWidget extends StatelessWidget {
  const MountainWidget({
    Key? key,
    required this.opacity,
    required this.mountain,
    required this.alignmenX,
    required this.scale,
  }) : super(key: key);

  final double opacity;
  final Mountain mountain;
  final double alignmenX;
  final double scale;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: opacity,
      child: Container(
        alignment: Alignment.bottomCenter,
        child: Hero(
          tag: mountain.name,
          child: Image.asset(
            mountain.imgBlank,
            alignment: Alignment(alignmenX, 0),
            height: MediaQuery.of(context).size.height * scale,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
