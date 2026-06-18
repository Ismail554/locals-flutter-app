import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locals/shared/components/auth_text_field.dart';
import 'package:locals/shared/theme/app_colors.dart';
import 'package:locals/core/localization/l10n_extensions.dart';

class LoginFormFields extends StatelessWidget {
  final bool obscurePassword;
  final ValueChanged<String> onEmailChanged;
  final ValueChanged<String> onPasswordChanged;
  final VoidCallback onTogglePassword;

  const LoginFormFields({
    super.key,
    required this.obscurePassword,
    required this.onEmailChanged,
    required this.onPasswordChanged,
    required this.onTogglePassword,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AuthTextField(
          label: context.l10n.authEmailLabel,
          hint: context.l10n.authEmailHint,
          prefixIcon: Icons.email_outlined,
          keyboardType: TextInputType.emailAddress,
          onChanged: onEmailChanged,
        ),
        SizedBox(height: 20.h),
        AuthTextField(
          label: context.l10n.authPasswordLabel,
          hint: context.l10n.authPasswordHint,
          prefixIcon: Icons.lock_outline,
          obscureText: obscurePassword,
          onChanged: onPasswordChanged,
          suffix: IconButton(
            onPressed: onTogglePassword,
            icon: Icon(
              obscurePassword ? Icons.visibility_outlined : Icons.visibility_off_outlined,
              color: AppColors.primaryPink,
              size: 20.sp,
            ),
          ),
        ),
      ],
    );
  }
}
