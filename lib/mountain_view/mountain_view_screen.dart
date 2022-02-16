import 'package:flutter/material.dart';
import 'package:flutter_challenges/mountain_view/widgets/mountain_background.dart';
import 'package:flutter_challenges/mountain_view/widgets/mountain_marker_image.dart';
import 'package:flutter_challenges/mountain_view/widgets/mountain_page_view.dart';
import 'package:flutter_challenges/mountain_view/widgets/page_mountain_widget.dart';

import 'data/mountains.dart';

class MountainViewScreen extends StatefulWidget {
  const MountainViewScreen({Key? key}) : super(key: key);

  @override
  _MountainViewScreenState createState() => _MountainViewScreenState();
}

class _MountainViewScreenState extends State<MountainViewScreen>
    with TickerProviderStateMixin {
  double _currentSliderValue = 0;
  Color? colorBackground;
  String descriptionBackground = '';
  int _currentIndex = 0;

  // animation for open description and mountain go down
  late AnimationController mountainAnimationController;

  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    pageController.addListener(_listener);
    colorBackground = listMountains[0].color;
    descriptionBackground = listMountains[0].desc;
    mountainAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));
    super.initState();
  }

  void _listener() {
    setState(() {
      _currentSliderValue = pageController.page!;
      _currentIndex = _currentSliderValue.toInt();
      int indexColor = (_currentSliderValue + 0.02).toInt();
      // if mountain is switched the scrollcontroller needs to go up again
      if (indexColor != _currentIndex) {
        _currentIndex = indexColor;
        scrollController.jumpTo(0);
      }
      colorBackground = listMountains[indexColor].color;
      descriptionBackground = listMountains[indexColor].desc;
    });
  }

  @override
  Widget build(BuildContext context) {
    double opacity = 1 + (_currentIndex - _currentSliderValue);
    if (opacity > 1) {
      opacity = 1 - (opacity * 0.2);
    } else if (opacity <= 0) {
      opacity = 0;
    }
    double factorSpace = -0.5;
    double alignmenX =
        (_currentIndex * factorSpace) + (_currentSliderValue / 2);
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Positioned.fill(
              child: MountainBackground(
                  colorBackground: colorBackground,
                  scrollController: scrollController,
                  mountainAnimationController: mountainAnimationController,
                  descriptionBackground: descriptionBackground),
            ),
            for (int i = listMountains.length - 1; i >= 0; i--)
              PageMountain(
                  mountain: listMountains[i],
                  animationValue: _currentSliderValue,
                  animationController: mountainAnimationController,
                  index: i),
            MountainPageView(
                mountainAnimationController: mountainAnimationController,
                pageController: pageController),
            Positioned(
              bottom: MediaQuery.of(context).size.height * 0.7 - 20,
              left: MediaQuery.of(context).size.width * 0.5 - 10,
              child: MountainMarkerImage(
                  mountainAnimationController: mountainAnimationController,
                  opacity: opacity,
                  alignmenX: alignmenX,
                  currentIndex: _currentIndex),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    mountainAnimationController.dispose();
    pageController.removeListener(_listener);
    pageController.dispose();
  }
}
