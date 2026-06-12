class LoginModel {
  final String email;
  final String password;
  final bool rememberMe;
  final bool obscurePassword;

  const LoginModel({
    this.email = '',
    this.password = '',
    this.rememberMe = false,
    this.obscurePassword = true,
  });

  LoginModel copyWith({
    String? email,
    String? password,
    bool? rememberMe,
    bool? obscurePassword,
  }) {
    return LoginModel(
      email: email ?? this.email,
      password: password ?? this.password,
      rememberMe: rememberMe ?? this.rememberMe,
      obscurePassword: obscurePassword ?? this.obscurePassword,
    );
  }
}
