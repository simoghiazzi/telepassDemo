import 'package:ghiazzi/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class UserSession {
  static final UserSession _instance = UserSession._internal();

  factory UserSession() {
    return _instance;
  }

  UserModel? _currentUser;

  UserModel? get currentUser => _currentUser;

  void setUser(UserModel user) {
    _currentUser = user;
    _saveUserToPrefs(user);
  }

  void clearUser() {
    _currentUser = null;
    _removeUserFromPrefs();
  }

  UserSession._internal() {
    // Do not call async code here directly
  }

  //We keep the logged user's information stored. If a logged user refreshesh the website, she/he is kept logged in
  Future<void> restoreSession() async {
    await _restoreUserFromPrefs();
  }

  Future<void> _saveUserToPrefs(UserModel user) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('user', jsonEncode(user.toJson()));
  }

  Future<void> _removeUserFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('user');
  }

  Future<void> _restoreUserFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    String? userJson = prefs.getString('user');
    if (userJson != null) {
      _currentUser = UserModel.fromJson(jsonDecode(userJson));
    }
  }
}
