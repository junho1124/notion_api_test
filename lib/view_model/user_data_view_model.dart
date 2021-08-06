import 'package:flutter/material.dart';
import 'package:notion_api_test/repository/user_data_repository.dart';

class UserDataViewModel extends ChangeNotifier {
  final repository = UserDataRepository();

  bool _isLogin = false;

  bool get isLogin => _isLogin;

  void login() async {
    if(await repository.getUserDB() != '') {
      _isLogin = true;
      notifyListeners();
    }
    return;
  }

  void logOut() {
    repository.clearUserData();
    _isLogin = false;
    notifyListeners();
  }

}