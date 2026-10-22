class VerifyOtpModel {
  final List<String> digits;
  final bool isLoading;
  final String? errorMessage;

  const VerifyOtpModel({
    this.digits = const ['', '', '', ''],
    this.isLoading = false,
    this.errorMessage,
  });

  VerifyOtpModel copyWith({
    List<String>? digits,
    bool? isLoading,
    String? errorMessage,
    bool clearError = false,
  }) {
    return VerifyOtpModel(
      digits: digits ?? this.digits,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }

  String get code => digits.join();

  bool get isComplete => digits.every((d) => d.isNotEmpty);
}