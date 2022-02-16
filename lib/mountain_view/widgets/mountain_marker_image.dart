import 'package:flutter/material.dart';
import 'package:flutter_challenges/mountain_view/data/mountains.dart';
import 'package:flutter_challenges/mountain_view/widgets/mountain_zoom_screen.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class MountainMarkerImage extends StatelessWidget {
  const MountainMarkerImage({
    Key? key,
    required this.mountainAnimationController,
    required this.opacity,
    required this.alignmenX,
    required int currentIndex,
  })  : _currentIndex = currentIndex,
        super(key: key);

  final AnimationController mountainAnimationController;
  final double opacity;
  final double alignmenX;
  final int _currentIndex;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: mountainAnimationController,
        builder: (context, _) {
          return Opacity(
            opacity: mountainAnimationController.value == 0 ? opacity : 0,
            child: Transform.translate(
              offset: Offset(
                  alignmenX * MediaQuery.of(context).size.width * 0.3,
                  alignmenX * MediaQuery.of(context).size.width * 0.3),
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
                        border: Border.all(color: Colors.white, width: 1)),
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
        });
  }
}
