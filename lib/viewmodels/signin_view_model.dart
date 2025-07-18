import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghiazzi/models/user_model.dart';
import 'package:ghiazzi/repositories/sign_in_repository.dart';
import 'package:ghiazzi/utils/utils.dart';
import 'package:ghiazzi/viewmodels/user_session.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class SigninState {}

class SigninInitial extends SigninState {}

class SigninLoading extends SigninState {}

class SigninError extends SigninState {
  final String message;
  SigninError(this.message);
}

class SigninEmailError extends SigninError {
  SigninEmailError(super.message);
}

class SinginPasswordError extends SigninError {
  SinginPasswordError(super.message);
}

class SigninSuccess extends SigninState {}

class SigninViewModel extends Cubit<SigninState> {
  final SigninRepository signinRepository;

  Map<String, String>? _authData;
  Map<String, String>? get authData => _authData;

  SigninViewModel(this.signinRepository) : super(SigninInitial());

  bool checkEmail(String email) {
    _authData ??= {};
    _authData!['email'] = email;
    bool validityCheck = Utils.isValidEmail(email);
    if (!validityCheck) {
      emit(SigninEmailError('Formato email non valido'));
      return false;
    } else {
      emit(SigninEmailError(''));
    }
    return true;
  }

  //We simulate that the password has to be at least 8 characters
  bool checkPassword(String password) {
    _authData ??= {};
    _authData!['password'] = password;
    if (password.length < 8) {
      emit(
        SinginPasswordError('La password deve contenere almeno 8 caratteri'),
      );
      return false;
    }
    return (true);
  }

  Future<void> signin() async {
    emit(SigninLoading());
    try {
      Map<String, dynamic> data = await signinRepository.signin(_authData!);
      UserModel user = UserModel.fromJson(data);

      UserSession().setUser(user);

      //The try-catch structure gives us the ooportunity to check non-nullabikity of the token
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('userToken', user.token!);

      emit(SigninSuccess());
    } catch (e) {
      emit(SigninError(e.toString()));
    }
  }
}
