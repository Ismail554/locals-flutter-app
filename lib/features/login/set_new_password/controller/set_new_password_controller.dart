import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:locals/core/network/api_client.dart';
import '../model/set_new_password_model.dart';
import '../repository/set_new_password_repository.dart';

class SetNewPasswordController extends ChangeNotifier {
  final SetNewPasswordRepository repo;
  final String email;
  final String resetToken;

  SetNewPasswordModel state = const SetNewPasswordModel();

  static const passwordRequirements = [
    'At least 8 characters',
    'Contains uppercase letter',
    'Contains lowercase letter',
    'Contains number',
  ];

  SetNewPasswordController(
    this.repo, {
    required this.email,
    required this.resetToken,
  });

  void setNewPassword(String value) {
    state = state.copyWith(newPassword: value, clearError: true);
    notifyListeners();
  }

  void setConfirmPassword(String value) {
    state = state.copyWith(confirmPassword: value, clearError: true);
    notifyListeners();
  }

  void toggleNewPasswordVisibility() {
    state = state.copyWith(obscureNewPassword: !state.obscureNewPassword);
    notifyListeners();
  }

  void toggleConfirmPasswordVisibility() {
    state = state.copyWith(
      obscureConfirmPassword: !state.obscureConfirmPassword,
    );
    notifyListeners();
  }

  Future<void> resetPassword(BuildContext context) async {
    if (!_validate()) return;

    state = state.copyWith(isLoading: true, clearError: true);
    notifyListeners();

    try {
      await repo.confirmPasswordReset(
        email: email,
        resetToken: resetToken,
        newPassword: state.newPassword,
        confirmPassword: state.confirmPassword,
      );

      state = state.copyWith(isLoading: false, isSuccess: true);
      notifyListeners();

      // Show success view for 2 seconds then go to login
      await Future<void>.delayed(const Duration(seconds: 2));

      if (context.mounted) {
        context.go('/login');
      }
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

  void goToLogin(BuildContext context) {
    context.go('/login');
  }

  bool _validate() {
    if (state.newPassword.length < 8) {
      state = state.copyWith(
        errorMessage: 'Password must be at least 8 characters.',
      );
      notifyListeners();
      return false;
    }
    if (state.newPassword != state.confirmPassword) {
      state = state.copyWith(errorMessage: 'Passwords do not match.');
      notifyListeners();
      return false;
    }
    return true;
  }
}
