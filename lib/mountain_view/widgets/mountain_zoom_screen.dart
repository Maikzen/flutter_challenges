import 'package:flutter/material.dart';
import 'package:flutter_challenges/mountain_view/models/mountain.dart';
import 'package:flutter_challenges/mountain_view/widgets/button_close_widget.dart';
import 'package:photo_view/photo_view.dart';

class MountainZoomScreen extends StatelessWidget {
  const MountainZoomScreen({Key? key, required this.mountain})
      : super(key: key);

  final Mountain mountain;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Hero(
          tag: mountain.name,
          child: PhotoView(
            imageProvider: AssetImage(mountain.img),
            initialScale: PhotoViewComputedScale.covered,
          ),
        ),
        Positioned(
          right: 20,
          top: MediaQuery.of(context).size.height * 0.1,
          child: ButtonClose(function: () {
            Navigator.of(context).pop();
          }),
        ),
      ],
    );
  }
}
