import 'package:flutter/material.dart';
import 'package:flutter_challenges/daily_ui/daily_ui_screen.dart';

class LightSwitch extends StatelessWidget {
  const LightSwitch(
      {Key? key,
      required LightState lightState,
      required AnimationController animationController})
      : _lightState = lightState,
        _animationController = animationController,
        super(key: key);

  final LightState _lightState;
  final AnimationController _animationController;

  final Color lightColorBackground = Colors.black26;
  final Color darkColorBackground = Colors.black;
  final double _padding = 10;

  @override
  Widget build(BuildContext context) {
    final double sizeSwitch =
        MediaQuery.of(context).size.width * 0.2 - _padding * 2;
    final double heightContainer = MediaQuery.of(context).size.height * 0.2;
    return Stack(
      children: [
        Column(
          children: [
            const Expanded(
              flex: 4,
              child: SizedBox(),
            ),
            Expanded(
              flex: 3,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: _padding),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (_animationController.isDismissed) {
                          _animationController.forward();
                        } else {
                          _animationController.reverse();
                        }
                      },
                      child: Container(
                          height: heightContainer,
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(40)),
                            color: _lightState == LightState.light
                                ? lightColorBackground
                                : darkColorBackground,
                          ),
                          child: Stack(
                            children: [
                              AnimatedBuilder(
                                  animation: _animationController,
                                  builder: (context, _) {
                                    return Positioned(
                                      top: _animationController.value *
                                          (heightContainer - sizeSwitch),
                                      height: sizeSwitch,
                                      width: sizeSwitch,
                                      bottom: null,
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Container(
                                          decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.white),
                                        ),
                                      ),
                                    );
                                  })
                            ],
                          )),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        AnimatedBuilder(
          animation: _animationController,
          builder: (context, _) {
            return Positioned(
              top: 0,
              width: 2,
              bottom: MediaQuery.of(context).size.height * 3/7 - 5 - ((heightContainer - _padding) * _animationController.value),
              left: _padding + sizeSwitch / 2,
              child: Container(
                color: Colors.white,
              ),
            );
          }
        )
      ],
    );
  }
}
