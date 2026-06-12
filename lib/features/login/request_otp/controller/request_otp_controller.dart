import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../model/request_otp_model.dart';
import '../repository/request_otp_repository.dart';

class RequestOtpController extends ChangeNotifier {
  final RequestOtpRepository repo;
  RequestOtpModel state = const RequestOtpModel();

  RequestOtpController(this.repo);

  void setEmail(String value) {
    state = state.copyWith(email: value);
    notifyListeners();
  }

  void requestOtp(BuildContext context) {
    context.push('/verify_otp');
  }

  void goBack(BuildContext context) {
    context.pop();
  }
}
