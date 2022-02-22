import 'package:flutter/material.dart';
import 'package:flutter_challenges/side_menu_animation/side_menu_animation_screen.dart';
import 'package:flutter_challenges/side_menu_animation/widgets/button_close_widget.dart';
import 'package:flutter_challenges/side_menu_animation/data/categories.dart';
import 'package:flutter_challenges/side_menu_animation/widgets/category_widget.dart';
import 'package:flutter_challenges/side_menu_animation/widgets/map_extension.dart';

class SideMenu extends StatelessWidget {
  const SideMenu(
      {Key? key,
      required this.listAnimationsController})
      : super(key: key);

  final List<AnimationController> listAnimationsController;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      width: MediaQuery.of(context).size.width * 0.2,
      bottom: 0,
      child: Column(
        children: [
          ButtonClose(
              animationController: listAnimationsController[0]),
          ...categories
              .mapIndexed(
                (i, e) => CategoryWidget(
                    index: i,
                    category: e,
                    animationController:
                        listAnimationsController[categories.indexOf(e) + 1]),
              )
              .toList()
        ],
      ),
    );
  }
}
