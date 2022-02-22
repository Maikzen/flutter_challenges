import 'package:flutter/material.dart';
import 'package:flutter_challenges/side_menu_animation/data/categories.dart';
import 'package:flutter_challenges/side_menu_animation/side_menu_bloc.dart';
import 'package:flutter_challenges/side_menu_animation/widgets/list_categories_widget.dart';
import 'package:flutter_challenges/side_menu_animation/widgets/side_menu.dart';

class SideMenuAnimationScreen extends StatefulWidget {
  const SideMenuAnimationScreen({Key? key}) : super(key: key);

  @override
  State<SideMenuAnimationScreen> createState() =>
      _SideMenuAnimationScreenState();
}

class _SideMenuAnimationScreenState extends State<SideMenuAnimationScreen>
    with TickerProviderStateMixin {
  bool showMenu = false;

  late List<AnimationController> _listAnimationsController;
  late AnimationController _animationController;

  final int _timeAnimation = 200;
  final int _timeAnimationView = 700;

  @override
  void initState() {
    _listAnimationsController = List.generate(
      categories.length + 1,
      (index) => AnimationController(
        vsync: this,
        duration: Duration(milliseconds: _timeAnimation),
      ),
    );
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: _timeAnimationView),
    );
    super.initState();
  }

  @override
  void dispose() {
    for (var element in _listAnimationsController) {
      element.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SideMenuAnimationInherented(
        sideMenuBloc: SideMenuBloc(_listAnimationsController, _animationController),
        child: Stack(
          children: [
            const ListCategories(),
            SideMenu(listAnimationsController: _listAnimationsController),
          ],
        ),
      ),
    );
  }
}

class SideMenuAnimationInherented extends InheritedWidget {
  // ignore: annotate_overrides, overridden_fields
  final Widget child;
  final SideMenuBloc sideMenuBloc;

  const SideMenuAnimationInherented(
      {Key? key, required this.child, required this.sideMenuBloc})
      : super(key: key, child: child);

  static SideMenuAnimationInherented? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<SideMenuAnimationInherented>();

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;
}
