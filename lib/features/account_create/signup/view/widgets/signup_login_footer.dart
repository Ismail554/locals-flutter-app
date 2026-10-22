import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locals/shared/theme/app_colors.dart';
import 'package:locals/core/localization/l10n_extensions.dart';

class SignupLoginFooter extends StatelessWidget {
  final VoidCallback onLogin;

  const SignupLoginFooter({super.key, required this.onLogin});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '${context.l10n.signupAlreadyLocal}  ',
          style: TextStyle(color: AppColors.textSecondary, fontSize: 14.sp, fontFamily: 'Inter', fontWeight: FontWeight.w400),
        ),
        GestureDetector(
          onTap: onLogin,
          child: Text(
            context.l10n.authLogIn,
            style: TextStyle(
              fontFamily: 'Inter',
              color: AppColors.primaryPink,
              fontSize: 14.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}
