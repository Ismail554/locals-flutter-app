import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../model/login_model.dart';
import '../repository/login_repository.dart';

class LoginController extends ChangeNotifier {
  final LoginRepository repo;
  LoginModel state = const LoginModel();

  LoginController(this.repo);

  void setEmail(String value) {
    state = state.copyWith(email: value);
    notifyListeners();
  }

  void setPassword(String value) {
    state = state.copyWith(password: value);
    notifyListeners();
  }

  void toggleRememberMe(bool? value) {
    state = state.copyWith(rememberMe: value ?? false);
    notifyListeners();
  }

  void togglePasswordVisibility() {
    state = state.copyWith(obscurePassword: !state.obscurePassword);
    notifyListeners();
  }

  void login(BuildContext context) {
    context.go('/map');
  }

  void goToForgotPassword(BuildContext context) {
    context.push('/request_otp');
  }

  void goToSignup(BuildContext context) {
    context.push('/signup');
  }
}
