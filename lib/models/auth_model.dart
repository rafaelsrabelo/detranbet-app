import 'package:flutter/material.dart';

class AuthModel extends ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void loginSuccess() {
    _isLoading = true;

    notifyListeners();
  }
}
