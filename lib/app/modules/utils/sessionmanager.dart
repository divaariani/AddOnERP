import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  static final String _keyIsLoggedIn = 'isLoggedIn';
  static final String _keyUserId = 'userId';
  static final String _keyUsername = 'username';

  static final SessionManager _instance = SessionManager._internal();

  factory SessionManager() {
    return _instance;
  }
  SessionManager._internal() {
    initPrefs();
  }

  late SharedPreferences _prefs;

  Future<void> initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> setLoggedIn(bool isLoggedIn) async {
    await _prefs.setBool(_keyIsLoggedIn, isLoggedIn);
  }

  Future<bool> isLoggedIn() async {
    return _prefs.getBool(_keyIsLoggedIn) ?? false;
  }

  Future<void> setUserId(String userId) async {
    await _prefs.setString(_keyUserId, userId);
  }

  Future<String?> getUserId() async {
    return _prefs.getString(_keyUserId);
  }

  Future<void> setUsername(String username) async {
    await _prefs.setString(_keyUsername, username);
  }

  Future<String?> getUsername() async {
    return _prefs.getString(_keyUsername);
  }

  Future<void> clearSession() async {
    await _prefs.clear();
  }
}