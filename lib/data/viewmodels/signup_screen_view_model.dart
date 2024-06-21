import 'package:flutter/material.dart';

class SignUpScreenViewModel extends ChangeNotifier{
  final GlobalKey<FormState> signUpFormKey = GlobalKey();

  String? _name;
  String? get name => _name;
  set name(String? value) {
    _name = value;
    notifyListeners();
  }

  String? _email;
  String? get email => _email;
  set email(String? value) {
    _email = value;
    notifyListeners();
  }

  String? _password;
  String? get password => _password;
  set password(String? value) {
    _password = value;
    notifyListeners();
  }
}