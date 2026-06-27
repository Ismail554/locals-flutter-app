import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:locals/core/network/api_client.dart';
import '../model/request_otp_model.dart';
import '../repository/request_otp_repository.dart';

class RequestOtpController extends ChangeNotifier {
  final RequestOtpRepository repo;
  RequestOtpModel state = const RequestOtpModel();

  RequestOtpController(this.repo);

  void setEmail(String value) {
    state = state.copyWith(email: value, clearError: true);
    notifyListeners();
  }

  Future<void> requestOtp(BuildContext context) async {
    if (state.email.trim().isEmpty) {
      state = state.copyWith(errorMessage: 'Please enter your email.');
      notifyListeners();
      return;
    }

    state = state.copyWith(isLoading: true, clearError: true);
    notifyListeners();

    try {
      await repo.requestPasswordReset(email: state.email.trim());

      if (!context.mounted) return;

      // Pass email to verify OTP screen
      context.push('/verify_otp', extra: state.email.trim());
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

  void goBack(BuildContext context) {
    context.pop();
  }
}
