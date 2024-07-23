import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class ProfilePageViewModel extends ChangeNotifier{

  ImagePicker _picker = ImagePicker();
  ImagePicker get picker => _picker;
  set picker(ImagePicker value){
    _picker = value;
    notifyListeners();
  }

  XFile? _image;
  XFile? get image => _image;
  set image(XFile? value){
    _image = value;
    notifyListeners();
  }

  String _imageUrl = "";
  String get imageUrl => _imageUrl;
  set imageUrl(String value){
    _imageUrl = value;
    notifyListeners();
  }

  // Additional method to get the date from the controller's text
  DateTime? get dob {
    if (_textControllerDOB.text.isEmpty) return null;
    return DateFormat('yyyy-MM-dd').parse(_textControllerDOB.text);
  }

  // Additional method to get the date from the controller's text
  DateTime? get anni {
    if (_textControllerAnniversary.text.isEmpty) return null;
    return DateFormat('yyyy-MM-dd').parse(_textControllerAnniversary.text);
  }

  bool _flag = true;
  bool get flag => _flag;
  set flag(bool value){
    _flag = value;
    notifyListeners();
  }

  TextEditingController _textControllerName = TextEditingController();
  TextEditingController get textContollerName => _textControllerName;
  set textControllerName(String value){
    _textControllerName.text = value;
    notifyListeners();
  }

  TextEditingController _textControllerMobile = TextEditingController();
  TextEditingController get textContollerMobile => _textControllerMobile;
  set textControllerMobile(String value){
    _textControllerMobile.text = value;
    notifyListeners();
  }

  TextEditingController _textControllerEmail = TextEditingController();
  TextEditingController get textContollerEmail => _textControllerEmail;
  set textControllerEmail(String value){
    _textControllerEmail.text = value;
    notifyListeners();
  }

  TextEditingController _textControllerDOB = TextEditingController();
  TextEditingController get textContollerDOB => _textControllerDOB;
  // Set method for DateTime
  set textControllerDOB(DateTime value) {
    _textControllerDOB.text = DateFormat('yyyy-MM-dd').format(value);
    notifyListeners();
  }

  TextEditingController _textControllerAnniversary = TextEditingController();
  TextEditingController get textContollerAnniversary => _textControllerAnniversary;
  set textControllerAnniversary(DateTime value){
    _textControllerAnniversary.text = DateFormat('yyyy-MM-dd').format(value);
    notifyListeners();
  }

  String _selectedGender = 'male';
  String get selectedGender => _selectedGender;
  set selectedGender(String value) {
    _selectedGender = value;
    notifyListeners();
  }

}