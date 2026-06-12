class VerifyOtpModel {
  final List<String> digits;

  const VerifyOtpModel({this.digits = const ['', '', '', '']});

  VerifyOtpModel copyWith({List<String>? digits}) {
    return VerifyOtpModel(digits: digits ?? this.digits);
  }

  String get code => digits.join();
}
