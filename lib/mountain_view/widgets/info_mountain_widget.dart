import 'package:flutter/material.dart';
import 'package:flutter_challenges/mountain_view/models/mountain.dart';
import 'package:flutter_challenges/mountain_view/widgets/attribute_mountain_widget.dart';

class InfoMountainWidget extends StatelessWidget {
  const InfoMountainWidget({
    Key? key,
    required this.opacityText,
    required this.scale,
    required this.mountain,
    required this.animationController,
  }) : super(key: key);

  final double opacityText;
  final double scale;
  final Mountain mountain;
  final AnimationController animationController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.3,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: nameMountainWidget(),
          ),
          Expanded(
            flex: 1,
            child: descriptionMountainWidget(),
          ),
        ],
      ),
    );
  }

  Widget descriptionMountainWidget() {
    return AnimatedBuilder(
      animation: animationController,
      builder: (context, child) {
        return Transform.translate(
            offset: Offset(animationController.value * MediaQuery.of(context).size.width, 0),
            child: Opacity(
              opacity: opacityText,
              child: Transform.scale(
                scale: scale,
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AttributeMountainWidget(
                      label: 'Elevación:',
                      value: mountain.elevacion,
                    ),
                    AttributeMountainWidget(
                      label: 'Localización:',
                      value: mountain.pais,
                    ),
                    TextButton(
                      onPressed: () {
                        showDetail();
                      },
                      child: const Text(
                        'Ver descripción',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white24)),
                    )
                  ],
                ),
              ),
            ));
      },
    );
  }

  Widget nameMountainWidget() {
    return Opacity(
      opacity: opacityText,
      child: Transform.scale(
        scale: scale,
        alignment: Alignment.center,
        child: Transform.translate(
          offset: const Offset(0, 0),
          child: Text(
            mountain.name.toUpperCase(),
            maxLines: 2,
            style: const TextStyle(
                color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  void showDetail() {
    animationController.forward();
  }
}
