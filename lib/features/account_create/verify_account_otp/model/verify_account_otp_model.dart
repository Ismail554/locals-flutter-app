class VerifyAccountOtpModel {
  final List<String> digits;
  final bool isSuccess;

  const VerifyAccountOtpModel({
    this.digits = const ['', '', '', ''],
    this.isSuccess = false,
  });

  VerifyAccountOtpModel copyWith({
    List<String>? digits,
    bool? isSuccess,
  }) {
    return VerifyAccountOtpModel(
      digits: digits ?? this.digits,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }

  String get code => digits.join();
}
