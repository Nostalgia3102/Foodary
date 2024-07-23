import 'package:flutter/material.dart';

import '../models/items.dart';
import '../models/pairs.dart';

class RestaurantPersonalPageViewModel extends ChangeNotifier {
  bool _visitingFirstTime = true;
  bool get visitingFirstTime => _visitingFirstTime;
  set visitingFirstTime(bool value) {
    _visitingFirstTime = value;
    notifyListeners();
  }

  bool _restaurantLiked = false;
  bool get restaurantLiked => _restaurantLiked;
  set restaurantLiked(bool value) {
    _restaurantLiked = value;
    notifyListeners();
  }


  int _numberOfItemsInCart = 0;
  int get numberOfItemsInCart => _numberOfItemsInCart;
  set numberOfItemsInCart(int value) {
    _numberOfItemsInCart = value;
    notifyListeners();
  }

  //List of items being displayed:
  List<Items> _listOfItems = [];    /// item - image - name - dec - price
  List<Items> get listOfItems => _listOfItems;
  set listOfItems(List<Items> value) {
    _listOfItems = value;
    notifyListeners();
  }

  List<String> _listOfIds = []; /// jo mai select kr rha hu inhi ids ka list : aka added to cart
  List<String> get listOfIds => _listOfIds;
  set listOfIds(List<String> value) {
    _listOfIds = value;
    notifyListeners();
  }

  void setState() {
    notifyListeners();
  }
}
