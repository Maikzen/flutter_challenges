import 'package:flutter/material.dart';

class OverlayWithHole extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Flutterclutter: Holes")),
      body: _getExperimentOne()
    );
  }

  Stack _getExperimentOne() {
    return Stack(children: <Widget>[
      _getContent(),
      _getClipPathOverlay()
    ]);
  }

  Widget _getContent() {
    return Container(
      color: Colors.redAccent,
      child: Center(
          child: Text("This is the Background")
      )
    );
  }

  ClipPath _getClipPathOverlay() {
    return ClipPath(
      clipper: InvertedClipper(),
        child: Container(
          color: Colors.black54,
        ),
    );
  }
}

class InvertedClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    return Path.combine(
      PathOperation.difference,
      Path()..addRect(
          Rect.fromLTWH(0, 0, size.width, size.height)
      ),
      Path()
        ..addOval(Rect.fromCircle(center: Offset(size.width -44, size.height - 44), radius: 40))
        ..close(),
    );
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}