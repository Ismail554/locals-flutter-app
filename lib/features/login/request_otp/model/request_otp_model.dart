class RequestOtpModel {
  final String email;
  final bool isLoading;
  final String? errorMessage;

  const RequestOtpModel({
    this.email = '',
    this.isLoading = false,
    this.errorMessage,
  });

  RequestOtpModel copyWith({
    String? email,
    bool? isLoading,
    String? errorMessage,
    bool clearError = false,
  }) {
    return RequestOtpModel(
      email: email ?? this.email,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }
}