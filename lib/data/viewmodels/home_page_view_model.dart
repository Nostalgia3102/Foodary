import 'package:flutter/material.dart';

class HomePageViewModel extends ChangeNotifier{
  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;
  set selectedIndex(int value){
    _selectedIndex = value;
    notifyListeners();
  }
}