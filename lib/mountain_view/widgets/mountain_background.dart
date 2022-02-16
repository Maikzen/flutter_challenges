import 'package:flutter/material.dart';

class MountainBackground extends StatelessWidget {
  const MountainBackground({
    Key? key,
    required this.colorBackground,
    required this.scrollController,
    required this.mountainAnimationController,
    required this.descriptionBackground,
  }) : super(key: key);

  final Color? colorBackground;
  final ScrollController scrollController;
  final AnimationController mountainAnimationController;
  final String descriptionBackground;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
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
    );
  }
}
