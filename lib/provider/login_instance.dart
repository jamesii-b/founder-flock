import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier {
  bool _isLogin = false;
  bool get isLogin => _isLogin;
  String _id = "";
  String get uID => _id;
  void updateuID(value) {
    _id = value;
    notifyListeners();
  }

  void updateLoginStatus(value) {
    _isLogin = value;
    notifyListeners();
  }
}
