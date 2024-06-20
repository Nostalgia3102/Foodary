import 'package:flutter/material.dart';

class WelcomeScreenViewModel extends ChangeNotifier{

  final PageController pageController = PageController(initialPage: 0);

  int _currentPage = 0;
  int get currentPage => _currentPage;
  set currentPage(int value){
    _currentPage = value;
    notifyListeners();
  }

}