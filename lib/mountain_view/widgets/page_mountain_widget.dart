import 'package:flutter/material.dart';
import 'package:flutter_challenges/mountain_view/models/mountain.dart';
import 'package:flutter_challenges/mountain_view/widgets/button_close_widget.dart';
import 'package:flutter_challenges/mountain_view/widgets/info_mountain_widget.dart';
import 'package:flutter_challenges/mountain_view/widgets/mountain_widget.dart';

class PageMountain extends StatelessWidget {
  const PageMountain(
      {Key? key,
      required this.mountain,
      required this.animationValue,
      required this.animationController,
      required this.index})
      : super(key: key);

  final Mountain mountain;
  final double animationValue;
  final AnimationController animationController;
  final int index;

  @override
  Widget build(BuildContext context) {
    double factorCorrectionPageView = 0.05;
    double factorSpace = -0.5;
    double factorOpacity = 0.2;
    double factorScale = 0.05;
    double factorScaleText = 0.2;
    double sizeMountain = 0.7;
    double sizeText = 0.8;
    double alignmenX = (index * factorSpace) + (animationValue / 2);
    double opacity = 1 + (index - animationValue - factorCorrectionPageView);
    if (opacity > 1) {
      opacity = 1 - (opacity * factorOpacity);
    } else if (opacity <= 0) {
      opacity = 0;
    }
    double scale =
        sizeMountain + (animationValue * factorScale) - (index * factorScale);
    double scaleText = sizeText +
        (animationValue * factorScaleText) -
        (index * factorScaleText);
    double opacityText = 1 + (animationValue - index);
    if (opacityText < 0 || opacityText >= 2) {
      opacityText = 0;
    } else if (opacityText >= 1) {
      opacityText = 1 - (opacityText - opacityText.toInt());
    }
    return Stack(
      children: [
        AnimatedBuilder(
          animation: animationController,
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(
                  0,
                  animationController
                                  .drive(
                                      CurveTween(curve: Curves.easeInOutBack))
                                  .value *
                              MediaQuery.of(context).size.height *
                              0.5 <
                          0
                      ? 0
                      : animationController
                              .drive(CurveTween(curve: Curves.easeInOutBack))
                              .value *
                          MediaQuery.of(context).size.height *
                          0.5),
              child: MountainWidget(
                  opacity: opacity,
                  mountain: mountain,
                  alignmenX: alignmenX,
                  scale: scale),
            );
          },
        ),
        InfoMountainWidget(
            opacityText: opacityText,
            scale: scaleText,
            mountain: mountain,
            animationController: animationController),
        AnimatedBuilder(
          animation: animationController,
          builder: (context, child) {
            return Positioned(
              right: -80 + animationController.value * 100,
              top: MediaQuery.of(context).size.height * 0.1,
              child: ButtonClose(function: () {
                animationController.reverse();
              }),
            );
          },
        ),
      ],
    );
  }
}
