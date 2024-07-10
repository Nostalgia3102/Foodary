import 'package:flutter/material.dart';

class RestaurantPageViewModel extends ChangeNotifier{

  int _numberOfListOfRestaurants = 0;
  int get numberOfListOfRestaurants => _numberOfListOfRestaurants;
  set numberOfListOfRestaurants(int value){
    _numberOfListOfRestaurants = value;
    notifyListeners();
  }

  List<String>? _vendorIds;
  List<String>? get vendorIds => _vendorIds;
  set vendorIds(List<String>? value){
    _vendorIds = value;
    notifyListeners();
  }
}