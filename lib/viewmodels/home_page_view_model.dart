import 'package:flutter/material.dart';

class HomePageViewModel extends ChangeNotifier{
  final List<int> numbers = [0];
  void add(){
    int last  = numbers.last;
    numbers.add(last+1);
    notifyListeners();
  }
}