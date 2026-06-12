import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../model/set_new_password_model.dart';
import '../repository/set_new_password_repository.dart';

class SetNewPasswordController extends ChangeNotifier {
  final SetNewPasswordRepository repo;
  SetNewPasswordModel state = const SetNewPasswordModel();

  static const passwordRequirements = [
    'At least 8 characters',
    'Contains uppercase letter',
    'Contains lowercase letter',
    'Contains number',
  ];

  SetNewPasswordController(this.repo);

  void setNewPassword(String value) {
    state = state.copyWith(newPassword: value);
    notifyListeners();
  }

  void setConfirmPassword(String value) {
    state = state.copyWith(confirmPassword: value);
    notifyListeners();
  }

  void toggleNewPasswordVisibility() {
    state = state.copyWith(obscureNewPassword: !state.obscureNewPassword);
    notifyListeners();
  }

  void toggleConfirmPasswordVisibility() {
    state = state.copyWith(obscureConfirmPassword: !state.obscureConfirmPassword);
    notifyListeners();
  }

  void resetPassword(BuildContext context) {
    state = state.copyWith(isSuccess: true);
    notifyListeners();
    Future<void>.delayed(const Duration(seconds: 2), () {
      if (context.mounted) {
        goToLogin(context);
      }
    });
  }

  void goToLogin(BuildContext context) {
    context.go('/login');
  }
}
