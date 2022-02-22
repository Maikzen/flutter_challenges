import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_challenges/side_menu_animation/side_menu_animation_screen.dart';
import 'package:flutter_challenges/side_menu_animation/side_menu_bloc.dart';

class ButtonClose extends StatefulWidget {
  const ButtonClose(
      {Key? key,
      required this.animationController})
      : super(key: key);

  final AnimationController animationController;

  @override
  State<ButtonClose> createState() => _ButtonCloseState();
}

class _ButtonCloseState extends State<ButtonClose> {
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
            child: Container(
              height: MediaQuery.of(context).size.width * 0.2,
              decoration: const BoxDecoration(
                border: Border.symmetric(
                    horizontal: BorderSide(color: Colors.blueGrey, width: 1)),
                color: Color.fromRGBO(25, 0, 51, 1),
              ),
              child: TextButton(
                onPressed: () {
                  sideMenuBloc.menuTap(false);
                },
                child: const Center(
                  child: Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ),
            ),
          );
        });
  }
}
