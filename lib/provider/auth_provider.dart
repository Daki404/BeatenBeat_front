import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthProvider with ChangeNotifier {
  bool _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;

  void login() {
    // 로그인 성공 시 호출되는 메서드
    _isLoggedIn = true;
    notifyListeners();
  }

  void logout() {
    // 로그아웃 시 호출되는 메서드
    _isLoggedIn = false;
    notifyListeners();
  }
}
