import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:locals/core/network/api_client.dart';
import 'package:locals/core/localization/l10n_extensions.dart';
import '../model/verify_account_otp_model.dart';
import '../repository/verify_account_otp_repository.dart';

class VerifyAccountOtpController extends ChangeNotifier {
  final VerifyAccountOtpRepository repo;
  final String email;

  VerifyAccountOtpModel state = const VerifyAccountOtpModel();

  bool isResending = false;

  final List<TextEditingController> digitControllers = List.generate(
    4,
    (_) => TextEditingController(),
  );
  final List<FocusNode> focusNodes = List.generate(4, (_) => FocusNode());

  VerifyAccountOtpController(this.repo, {required this.email});

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
      await repo.verifyOtp(email: email, code: state.code);

      state = state.copyWith(isLoading: false, isSuccess: true);
      notifyListeners();

      await Future<void>.delayed(const Duration(seconds: 2));

      if (context.mounted) {
        context.go('/map');
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

  Future<void> resendCode(BuildContext context) async {
    if (isResending) return;

    isResending = true;
    state = state.copyWith(clearError: true);
    notifyListeners();

    try {
      await repo.resendOtp(email: email);

      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.l10n.otpResendSuccess)),
      );
    } on ApiException catch (e) {
      state = state.copyWith(errorMessage: e.message);
      notifyListeners();
    } catch (_) {
      state = state.copyWith(
        errorMessage: 'Something went wrong. Please try again.',
      );
      notifyListeners();
    } finally {
      isResending = false;
      notifyListeners();
    }
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
