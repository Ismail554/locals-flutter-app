import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:locals/core/network/api_client.dart';
import '../model/verify_otp_model.dart';
import '../repository/verify_otp_repository.dart';

class VerifyOtpController extends ChangeNotifier {
  final VerifyOtpRepository repo;
  final String email;

  VerifyOtpModel state = const VerifyOtpModel();

  final List<TextEditingController> digitControllers = List.generate(
    4,
    (_) => TextEditingController(),
  );
  final List<FocusNode> focusNodes = List.generate(4, (_) => FocusNode());

  VerifyOtpController(this.repo, {required this.email});

  void onDigitChanged(int index, String value) {
    final digits = List<String>.from(state.digits);
    digits[index] = value.isNotEmpty ? value.substring(value.length - 1) : '';
    state = state.copyWith(digits: digits, clearError: true);
    notifyListeners();

    if (value.isNotEmpty && index < 3) {
      focusNodes[index + 1].requestFocus();
    }
  }

  Future<void> verifyOtp(BuildContext context) async {
    if (!state.isComplete) {
      state = state.copyWith(errorMessage: 'Please enter the 4-digit code.');
      notifyListeners();
      return;
    }

    state = state.copyWith(isLoading: true, clearError: true);
    notifyListeners();

    try {
      final resetToken = await repo.verifyOtp(email: email, code: state.code);

      if (!context.mounted) return;

      context.push(
        '/set_new_password',
        extra: {'email': email, 'reset_token': resetToken},
      );
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

  void resendCode() {
    // Wire up resend OTP when endpoint is available
  }

  void goBack(BuildContext context) {
    context.pop();
  }

  @override
  void dispose() {
    for (final c in digitControllers) {
      c.dispose();
    }
    for (final n in focusNodes) {
      n.dispose();
    }
    super.dispose();
  }
}
