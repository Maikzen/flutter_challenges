import 'package:flutter/material.dart';
import 'package:flutter_challenges/mountain_view/widgets/mountain_zoom_screen.dart';
import 'package:flutter_challenges/mountain_view/widgets/page_mountain_widget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

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

  late AnimationController mountainAnimationController;
  late Animation<double> opacityTween;

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
    opacityTween =
        Tween<double>(begin: 0, end: 1).animate(mountainAnimationController);
    super.initState();
  }

  void _listener() {
    setState(() {
      _currentSliderValue = pageController.page!;
      _currentIndex = _currentSliderValue.toInt();
      int indexColor = (_currentSliderValue + 0.02).toInt();
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
    double opacity = 1 + (_currentIndex - _currentSliderValue );
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
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                color: colorBackground,
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.2,
                        ),
                        AnimatedBuilder(
                            animation: mountainAnimationController,
                            builder: (context, _) {
                              return Opacity(
                                opacity: mountainAnimationController.value,
                                child: Text(
                                  descriptionBackground,
                                  style: const TextStyle(color: Colors.white),
                                ),
                              );
                            }),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.2,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            for (int i = listMountains.length - 1; i >= 0; i--)
              PageMountain(
                  mountain: listMountains[i],
                  animationValue: _currentSliderValue,
                  animationController: mountainAnimationController,
                  index: i),
            AnimatedBuilder(
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
            ),
            Positioned(
              bottom: MediaQuery.of(context).size.height * 0.7 - 20,
              left: MediaQuery.of(context).size.width * 0.5 - 10,
              child: AnimatedBuilder(
                  animation: opacityTween,
                  builder: (context, _) {
                    return Opacity(
                      opacity: opacityTween.value == 0 ? opacity : 0,
                      child: Transform.translate(
                        offset: Offset(
                            alignmenX * MediaQuery.of(context).size.width * 0.3,
                            alignmenX *
                                MediaQuery.of(context).size.width *
                                0.3),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                                height: 1,
                                width: MediaQuery.of(context).size.width * 0.2,
                                color: Colors.white),
                            Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: Colors.white, width: 1)),
                              child: IconButton(
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(),
                                onPressed: () {
                                  
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => MountainZoomScreen(
                                        mountain: listMountains[_currentIndex]),
                                  ));
                                },
                                icon: const Icon(
                                  MdiIcons.imageFilterHdr,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    pageController.removeListener(_listener);
    pageController.dispose();
  }
}

extension FicListExtension<T> on List<T> {
  Iterable<E> mapIndexed<E>(E Function(int index, T item) map) sync* {
    for (var index = 0; index < length; index++) {
      yield map(index, this[index]);
    }
  }
}
