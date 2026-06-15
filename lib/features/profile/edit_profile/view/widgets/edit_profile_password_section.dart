import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locals/shared/components/primary_button.dart';
import 'package:locals/shared/theme/app_colors.dart';
import 'edit_profile_form_field.dart';

class EditProfilePasswordSection extends StatelessWidget {
  final TextEditingController currentPasswordController;
  final TextEditingController newPasswordController;
  final TextEditingController confirmPasswordController;
  final bool obscureCurrentPassword;
  final bool obscureNewPassword;
  final bool obscureConfirmPassword;
  final VoidCallback onToggleCurrentPassword;
  final VoidCallback onToggleNewPassword;
  final VoidCallback onToggleConfirmPassword;
  final VoidCallback onChangePassword;

  const EditProfilePasswordSection({
    super.key,
    required this.currentPasswordController,
    required this.newPasswordController,
    required this.confirmPasswordController,
    required this.obscureCurrentPassword,
    required this.obscureNewPassword,
    required this.obscureConfirmPassword,
    required this.onToggleCurrentPassword,
    required this.onToggleNewPassword,
    required this.onToggleConfirmPassword,
    required this.onChangePassword,
  });

  Widget _visibilityToggle({
    required bool obscure,
    required VoidCallback onTap,
  }) {
    return IconButton(
      onPressed: onTap,
      icon: Icon(
        obscure ? Icons.visibility_outlined : Icons.visibility_off_outlined,
        color: AppColors.textSecondary,
        size: 20.sp,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Change password',
          style: TextStyle(
            color: AppColors.black,
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 16.h),
        EditProfileFormField(
          label: 'Current password',
          controller: currentPasswordController,
          obscureText: obscureCurrentPassword,
          suffix: _visibilityToggle(
            obscure: obscureCurrentPassword,
            onTap: onToggleCurrentPassword,
          ),
        ),
        SizedBox(height: 16.h),
        EditProfileFormField(
          label: 'New password',
          controller: newPasswordController,
          obscureText: obscureNewPassword,
          suffix: _visibilityToggle(
            obscure: obscureNewPassword,
            onTap: onToggleNewPassword,
          ),
        ),
        SizedBox(height: 16.h),
        EditProfileFormField(
          label: 'Confirm password',
          controller: confirmPasswordController,
          obscureText: obscureConfirmPassword,
          suffix: _visibilityToggle(
            obscure: obscureConfirmPassword,
            onTap: onToggleConfirmPassword,
          ),
        ),
        SizedBox(height: 20.h),
        PrimaryButton(
          label: 'Change password',
          onPressed: onChangePassword,
        ),
      ],
    );
  }
}
