class SignupModel {
  final String name;
  final String email;
  final String password;
  final String confirmPassword;
  final bool obscurePassword;
  final bool obscureConfirmPassword;
  final bool isLoading;
  final String? errorMessage;

  const SignupModel({
    this.name = '',
    this.email = '',
    this.password = '',
    this.confirmPassword = '',
    this.obscurePassword = true,
    this.obscureConfirmPassword = true,
    this.isLoading = false,
    this.errorMessage,
  });

  SignupModel copyWith({
    String? name,
    String? email,
    String? password,
    String? confirmPassword,
    bool? obscurePassword,
    bool? obscureConfirmPassword,
    bool? isLoading,
    String? errorMessage,
    bool clearError = false,
  }) {
    return SignupModel(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      obscurePassword: obscurePassword ?? this.obscurePassword,
      obscureConfirmPassword:
          obscureConfirmPassword ?? this.obscureConfirmPassword,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }
}