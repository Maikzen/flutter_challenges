import 'package:flutter/material.dart';
import 'package:flutter_challenges/side_menu_animation/data/categories.dart';
import 'package:flutter_challenges/side_menu_animation/models/category.dart';

class SideMenuBloc extends ChangeNotifier {
  final int _delay = 100;
  int currentIndex = 0;
  late List<AnimationController> _listAnimationsController;
  List<Category> listCategoriesView = [categories.first];

  late AnimationController animationListViewController;

  SideMenuBloc(List<AnimationController> listAnimationsController, AnimationController animationController) {
    _listAnimationsController = listAnimationsController;
    animationListViewController = animationController;
    animationListViewController.addListener(_listener);
  }

  void changeCategory(int nCategory) {
    currentIndex = nCategory;
    listCategoriesView.insert(0, categories[currentIndex]);
    animationListViewController.forward();
    closeMenu();
    notifyListeners();
  }

  void _listener(){
    // when animation is completed remove unused listview from stack
    if(animationListViewController.isCompleted){
      listCategoriesView.removeAt(1);
      animationListViewController.reset();
      notifyListeners();
    }
  }

  void menuTap(bool show) {
    if (show) {
      openMenu();
    } else {
      closeMenu();
    }
  }

  void openMenu() {
    for (var i = 0; i < _listAnimationsController.length; i++) {
      Future.delayed(Duration(milliseconds: i * _delay))
          .then((value) => _listAnimationsController[i].forward());
    }
  }

  void closeMenu() {
    for (var i = 0; i < _listAnimationsController.length; i++) {
      Future.delayed(Duration(milliseconds: i * _delay))
          .then((value) => _listAnimationsController[i].reverse());
    }
  }

}
