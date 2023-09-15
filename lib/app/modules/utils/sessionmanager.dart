import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  static const String _keyIsLoggedIn = 'isLoggedIn';
  static const String _keyUserId = 'userId';
  static const String _keyUsername = 'username';
  static const String _keyAuthToken = 'authToken';
  static const String _keyUserProfile = 'userProfile';

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

  Future<void> setUserProfile(String userProfile) async {
    await _prefs.setString(_keyUserProfile, userProfile);
  }

  Future<String?> getUserProfile() async {
    return _prefs.getString(_keyUserProfile);
  }

    Future<void> setAuthToken(String token) async {
    await _prefs.setString(_keyAuthToken, token); 
  }

  Future<String?> getAuthToken() async {
    return _prefs.getString(_keyAuthToken); 
  }

  Future<void> clearAuthToken() async {
    await _prefs.remove(_keyAuthToken);
  }
}
