import 'package:ghiazzi/models/user_model.dart';

class UserSession {
  static final UserSession _instance = UserSession._internal();

  factory UserSession() {
    return _instance;
  }

  UserModel? _currentUser;

  UserModel? get currentUser => _currentUser;

  void setUser(UserModel user) {
    _currentUser = user;
  }

  void clearUser() {
    _currentUser = null;
  }

  UserSession._internal();
}
