import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../model/verify_account_otp_model.dart';
import '../repository/verify_account_otp_repository.dart';

class VerifyAccountOtpController extends ChangeNotifier {
  final VerifyAccountOtpRepository repo;
  VerifyAccountOtpModel state = const VerifyAccountOtpModel();
  final List<TextEditingController> digitControllers =
      List.generate(4, (_) => TextEditingController());
  final List<FocusNode> focusNodes = List.generate(4, (_) => FocusNode());

  VerifyAccountOtpController(this.repo);

  void onDigitChanged(int index, String value) {
    final digits = List<String>.from(state.digits);
    digits[index] = value.isNotEmpty ? value.substring(value.length - 1) : '';
    state = state.copyWith(digits: digits);
    notifyListeners();

    if (value.isNotEmpty && index < 3) {
      focusNodes[index + 1].requestFocus();
    }
  }

  void verifyOtp(BuildContext context) {
    state = state.copyWith(isSuccess: true);
    notifyListeners();
    Future<void>.delayed(const Duration(seconds: 2), () {
      if (context.mounted) {
        context.go('/map');
      }
    });
  }

  void resendCode() {
    notifyListeners();
  }

  void goBack(BuildContext context) {
    context.pop();
  }

  @override
  void dispose() {
    for (final controller in digitControllers) {
      controller.dispose();
    }
    for (final node in focusNodes) {
      node.dispose();
    }
    super.dispose();
  }
}
