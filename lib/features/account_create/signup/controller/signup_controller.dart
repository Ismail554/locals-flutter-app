import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../model/signup_model.dart';
import '../repository/signup_repository.dart';

class SignupController extends ChangeNotifier {
  final SignupRepository repo;
  SignupModel state = const SignupModel();

  SignupController(this.repo);

  void setName(String value) {
    state = state.copyWith(name: value);
    notifyListeners();
  }

  void setEmail(String value) {
    state = state.copyWith(email: value);
    notifyListeners();
  }

  void setPassword(String value) {
    state = state.copyWith(password: value);
    notifyListeners();
  }

  void togglePasswordVisibility() {
    state = state.copyWith(obscurePassword: !state.obscurePassword);
    notifyListeners();
  }

  void createAccount(BuildContext context) {
    context.push('/verify_account_otp');
  }

  void signInWithGoogle(BuildContext context) {
    context.push('/verify_account_otp');
  }

  void goToLogin(BuildContext context) {
    context.go('/login');
  }
}
