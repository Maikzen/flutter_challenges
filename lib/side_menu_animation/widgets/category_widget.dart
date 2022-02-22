import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_challenges/side_menu_animation/models/category.dart';
import 'package:flutter_challenges/side_menu_animation/side_menu_animation_screen.dart';
import 'package:flutter_challenges/side_menu_animation/side_menu_bloc.dart';

class CategoryWidget extends StatefulWidget {
  const CategoryWidget(
      {Key? key, required this.index, required this.category, required this.animationController})
      : super(key: key);

  final int index;
  final Category category;
  final AnimationController animationController;

  @override
  State<CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SideMenuBloc sideMenuBloc = SideMenuAnimationInherented.of(context)!.sideMenuBloc;
    return AnimatedBuilder(
        animation: widget.animationController,
        builder: (context, _) {
          return Transform(
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.002)
              ..rotateY(-pi / 2 * (1 - widget.animationController.value)),
            child: AnimatedBuilder(
              animation: sideMenuBloc,
              builder: (context, _) {
                return Container(
                  width: MediaQuery.of(context).size.width * 0.2,
                  height: MediaQuery.of(context).size.width * 0.2,
                  decoration: BoxDecoration(
                    border: const Border.symmetric(
                        horizontal: BorderSide(color: Colors.blueGrey, width: 1)),
                    color: sideMenuBloc.currentIndex == widget.index ? Colors.purple : const Color.fromRGBO(25, 0, 51, 1),
                  ),
                  child: TextButton(
                    onPressed: () {
                      sideMenuBloc.changeCategory(widget.index);
                    },
                    child: Center(
                      child: Icon(
                        widget.category.icon,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
                );
              }
            ),
          );
        });
  }
}
