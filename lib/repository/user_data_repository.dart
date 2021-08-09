import 'package:shared_preferences/shared_preferences.dart';

class UserDataRepository {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<SharedPreferences> get prefs => _prefs;

  Future<void> putUserData(String token, String db) async {
    final prefs = await _prefs;
    prefs.setString('token', token);
    prefs.setString('db', db);
    prefs.setBool('isLogin', true);
  }

  Future<String> getUserToken() async {
    final prefs = await _prefs;
    return prefs.getString('token') ?? '';
  }
  Future<String> getUserDB() async {
    final prefs = await _prefs;
    return prefs.getString('db') ?? '';
  }

  void clearUserData() async {
    final prefs = await _prefs;
    prefs.clear();
    prefs.setBool('isLogin', false);
  }
}