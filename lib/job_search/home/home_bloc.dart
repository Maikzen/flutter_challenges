import 'package:flutter/material.dart';

class HomeBloc extends ChangeNotifier {
  final ScrollController scrollController = ScrollController();
  double offset = 0;

  HomeBloc() {
    _init();
  }

  void _init() {
    scrollController.addListener(() {
      offset = scrollController.offset;
      notifyListeners();
    });
  }
}
