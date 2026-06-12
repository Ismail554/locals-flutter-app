class SignupModel {
  final String name;
  final String email;
  final String password;
  final bool obscurePassword;

  const SignupModel({
    this.name = '',
    this.email = '',
    this.password = '',
    this.obscurePassword = true,
  });

  SignupModel copyWith({
    String? name,
    String? email,
    String? password,
    bool? obscurePassword,
  }) {
    return SignupModel(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      obscurePassword: obscurePassword ?? this.obscurePassword,
    );
  }
}
