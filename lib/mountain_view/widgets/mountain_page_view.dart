import 'package:flutter/material.dart';
import 'package:flutter_challenges/mountain_view/data/mountains.dart';
import 'package:flutter_challenges/mountain_view/widgets/map_extension.dart';

class MountainPageView extends StatelessWidget {
  const MountainPageView({
    Key? key,
    required this.mountainAnimationController,
    required this.pageController,
  }) : super(key: key);

  final AnimationController mountainAnimationController;
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: mountainAnimationController,
      builder: (context, child) {
        return Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.7 -
                mountainAnimationController.value *
                    MediaQuery.of(context).size.height *
                    0.5,
            child: PageView(
              controller: pageController,
              children: listMountains
                  .mapIndexed((index, item) => Container())
                  .toList(),
            ),
          ),
        );
      },
    );
  }
}
