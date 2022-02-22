import 'package:flutter/material.dart';
import 'package:flutter_challenges/side_menu_animation/data/categories.dart';
import 'package:flutter_challenges/side_menu_animation/models/category.dart';
import 'package:flutter_challenges/side_menu_animation/side_menu_animation_screen.dart';
import 'package:flutter_challenges/side_menu_animation/side_menu_bloc.dart';
import 'package:flutter_challenges/side_menu_animation/widgets/subcategory_widget.dart';
import 'package:flutter_challenges/side_menu_animation/widgets/map_extension.dart';

class ListCategories extends StatelessWidget {
  const ListCategories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SideMenuBloc sideMenuBloc =
        SideMenuAnimationInherented.of(context)!.sideMenuBloc;
    return AnimatedBuilder(
        animation: sideMenuBloc,
        builder: (context, _) {
          return Scaffold(
            appBar: _appBar(context),
            body: Stack(
                children: sideMenuBloc.listCategoriesView
                    .mapIndexed((i, e) => _getListViewByCategory(i, e, context))
                    .toList()),
          );
        });
  }

  Widget _getListViewByCategory(
      int index, Category category, BuildContext context) {
    Widget listView = ListView(
      children: category.subcategories
          .map((e) => SubcategoryWidget(
                subcategory: e,
              ))
          .toList(),
    );
    SideMenuBloc sideMenuBloc =
        SideMenuAnimationInherented.of(context)!.sideMenuBloc;
    if (sideMenuBloc.listCategoriesView.length == 2 && index == 1) {
      return AnimatedBuilder(
          animation: sideMenuBloc.animationListViewController,
          builder: (context, _) {
            return ClipPath(
              clipper: InvertedClipper(
                  sideMenuBloc.currentIndex,
                  sideMenuBloc.animationListViewController.value *
                      MediaQuery.of(context).size.height),
              child: listView,
            );
          });
    }
    return listView;
  }

  AppBar _appBar(BuildContext context) {
    SideMenuBloc sideMenuBloc =
        SideMenuAnimationInherented.of(context)!.sideMenuBloc;
    return AppBar(
      backgroundColor: Colors.white,
      title: Text(
        categories[sideMenuBloc.currentIndex].name,
        style: const TextStyle(color: Colors.black),
      ),
      centerTitle: true,
      leading: IconButton(
          onPressed: () {
            sideMenuBloc.menuTap(true);
          },
          icon: const Icon(
            Icons.menu,
            color: Colors.black,
          )),
    );
  }
}

class InvertedClipper extends CustomClipper<Path> {
  int currentIndex;
  double radius;

  InvertedClipper(this.currentIndex, this.radius);

  @override
  Path getClip(Size size) {
    double heightButton = size.width * 0.2;
    return Path.combine(
      PathOperation.difference,
      Path()..addRect(Rect.fromLTWH(0, 0, size.width, size.height)),
      Path()
        ..addOval(
          Rect.fromCircle(
              center: Offset(heightButton / 2,
                  heightButton * currentIndex + heightButton / 2),
              radius: radius),
        )
        ..close(),
    );
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
