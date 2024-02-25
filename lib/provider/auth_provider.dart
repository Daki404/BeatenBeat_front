import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  bool _isLoggedIn = false;
  String _myId = "";

  bool get isLoggedIn => _isLoggedIn;
  String get myId => _myId;

  void login(String myId) {
    // 로그인 성공 시 호출되는 메서드
    _isLoggedIn = true;
    _myId = myId;
    notifyListeners();
  }

  void logout() {
    // 로그아웃 시 호출되는 메서드
    _isLoggedIn = false;
    _myId = "";
    notifyListeners();
  }
}
