import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:locals/core/network/api_client.dart';
import '../model/login_model.dart';
import '../repository/login_repository.dart';

class LoginController extends ChangeNotifier {
  final LoginRepository repo;
  LoginModel state = const LoginModel();

  LoginController(this.repo);

  void setEmail(String value) {
    state = state.copyWith(email: value, clearError: true);
    notifyListeners();
  }

  void setPassword(String value) {
    state = state.copyWith(password: value, clearError: true);
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

  Future<void> login(BuildContext context) async {
    if (!_validate()) return;

    state = state.copyWith(isLoading: true, clearError: true);
    notifyListeners();

    try {
      await repo.login(email: state.email.trim(), password: state.password);

      if (!context.mounted) return;
      context.go('/map');
    } on ApiException catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.message);
      notifyListeners();
    } catch (_) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Something went wrong. Please try again.',
      );
      notifyListeners();
    }
  }

  void goToForgotPassword(BuildContext context) {
    context.push('/request_otp');
  }

  void goToSignup(BuildContext context) {
    context.push('/signup');
  }

  bool _validate() {
    if (state.email.trim().isEmpty) {
      state = state.copyWith(errorMessage: 'Please enter your email.');
      notifyListeners();
      return false;
    }
    if (state.password.isEmpty) {
      state = state.copyWith(errorMessage: 'Please enter your password.');
      notifyListeners();
      return false;
    }
    return true;
  }
}
