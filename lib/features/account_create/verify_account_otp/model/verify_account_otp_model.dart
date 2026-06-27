class VerifyAccountOtpModel {
  final List<String> digits;
  final bool isLoading;
  final bool isSuccess;
  final String? errorMessage;

  const VerifyAccountOtpModel({
    this.digits = const ['', '', '', ''],
    this.isLoading = false,
    this.isSuccess = false,
    this.errorMessage,
  });

  VerifyAccountOtpModel copyWith({
    List<String>? digits,
    bool? isLoading,
    bool? isSuccess,
    String? errorMessage,
    bool clearError = false,
  }) {
    return VerifyAccountOtpModel(
      digits: digits ?? this.digits,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }

  String get code => digits.join();

  bool get isComplete => digits.every((d) => d.isNotEmpty);
}