import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:locals/core/network/api_client.dart';
import '../model/signup_model.dart';
import '../repository/signup_repository.dart';

class SignupController extends ChangeNotifier {
  final SignupRepository repo;
  SignupModel state = const SignupModel();

  SignupController(this.repo);

  void setName(String value) {
    state = state.copyWith(name: value, clearError: true);
    notifyListeners();
  }

  void setEmail(String value) {
    state = state.copyWith(email: value, clearError: true);
    notifyListeners();
  }

  void setPassword(String value) {
    state = state.copyWith(password: value, clearError: true);
    notifyListeners();
  }

  void setConfirmPassword(String value) {
    state = state.copyWith(confirmPassword: value, clearError: true);
    notifyListeners();
  }

  void togglePasswordVisibility() {
    state = state.copyWith(obscurePassword: !state.obscurePassword);
    notifyListeners();
  }

  void toggleConfirmPasswordVisibility() {
    state = state.copyWith(
      obscureConfirmPassword: !state.obscureConfirmPassword,
    );
    notifyListeners();
  }

  Future<void> createAccount(BuildContext context) async {
    if (!_validate()) return;

    state = state.copyWith(isLoading: true, clearError: true);
    notifyListeners();

    try {
      await repo.register(
        fullName: state.name.trim(),
        email: state.email.trim(),
        password: state.password,
        confirmPassword: state.confirmPassword,
      );

      if (!context.mounted) return;
      context.push('/verify_account_otp', extra: state.email.trim());
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

  Future<void> signInWithGoogle(BuildContext context) async {
    // Google sign-in integration placeholder
  }

  void goToLogin(BuildContext context) {
    context.go('/login');
  }

  bool _validate() {
    if (state.name.trim().isEmpty) {
      state = state.copyWith(errorMessage: 'Please enter your full name.');
      notifyListeners();
      return false;
    }
    if (state.email.trim().isEmpty) {
      state = state.copyWith(errorMessage: 'Please enter your email.');
      notifyListeners();
      return false;
    }
    if (state.password.length < 6) {
      state = state.copyWith(
        errorMessage: 'Password must be at least 6 characters.',
      );
      notifyListeners();
      return false;
    }
    if (state.password != state.confirmPassword) {
      state = state.copyWith(errorMessage: 'Passwords do not match.');
      notifyListeners();
      return false;
    }
    return true;
  }
}
