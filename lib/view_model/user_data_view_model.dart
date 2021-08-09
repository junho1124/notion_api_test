import 'package:flutter/material.dart';
import 'package:notion_api_test/repository/user_data_repository.dart';

class UserDataViewModel extends ChangeNotifier {
  final repository = UserDataRepository();

  bool _isLogin = false;

  bool get isLogin => _isLogin;

  void login() async {
      await repository.prefs.then((value) {
        _isLogin = value.getBool('isLogin') ?? false;
        notifyListeners();
      });
  }

  void logOut() async {
    repository.clearUserData();
    await repository.prefs.then((value) {
      _isLogin = value.getBool('isLogin') ?? false;
      notifyListeners();
    });
  }

}