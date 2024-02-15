import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  bool _isLogin = false;
  bool get isLogin => _isLogin;
  String _id = "";
  String get uID => _id;
  void updateuID(value) {
    _id = value;
    notifyListeners();
  }

  String _email = "";
  String get email => _email;
  void updateEmail(value) {
    _email = value;
    notifyListeners();
  }

  void updateLoginStatus(value) {
    _isLogin = value;
    notifyListeners();
  }
}
