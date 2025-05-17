import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghiazzi/repositories/sign_in_repository.dart';

abstract class SigninState {}

class SigninInitial extends SigninState {}

class SigninLoading extends SigninState {}

class SigninError extends SigninState {
  final String message;
  SigninError(this.message);
}

class SigninSuccess extends SigninState {}

class SigninViewModel extends Cubit<SigninState> {
  final SigninRepository signinRepository;

  SigninViewModel(this.signinRepository) : super(SigninInitial());
}
