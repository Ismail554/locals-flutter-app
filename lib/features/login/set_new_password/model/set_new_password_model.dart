class SetNewPasswordModel {
  final String newPassword;
  final String confirmPassword;
  final bool obscureNewPassword;
  final bool obscureConfirmPassword;
  final bool isSuccess;

  const SetNewPasswordModel({
    this.newPassword = '',
    this.confirmPassword = '',
    this.obscureNewPassword = true,
    this.obscureConfirmPassword = true,
    this.isSuccess = false,
  });

  SetNewPasswordModel copyWith({
    String? newPassword,
    String? confirmPassword,
    bool? obscureNewPassword,
    bool? obscureConfirmPassword,
    bool? isSuccess,
  }) {
    return SetNewPasswordModel(
      newPassword: newPassword ?? this.newPassword,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      obscureNewPassword: obscureNewPassword ?? this.obscureNewPassword,
      obscureConfirmPassword: obscureConfirmPassword ?? this.obscureConfirmPassword,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }
}
