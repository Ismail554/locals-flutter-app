class LoginModel {
  final String email;
  final String password;
  final bool rememberMe;
  final bool obscurePassword;
  final bool isLoading;
  final String? errorMessage;

  const LoginModel({
    this.email = '',
    this.password = '',
    this.rememberMe = false,
    this.obscurePassword = true,
    this.isLoading = false,
    this.errorMessage,
  });

  LoginModel copyWith({
    String? email,
    String? password,
    bool? rememberMe,
    bool? obscurePassword,
    bool? isLoading,
    String? errorMessage,
    bool clearError = false,
  }) {
    return LoginModel(
      email: email ?? this.email,
      password: password ?? this.password,
      rememberMe: rememberMe ?? this.rememberMe,
      obscurePassword: obscurePassword ?? this.obscurePassword,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }
}