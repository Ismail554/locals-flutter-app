import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:locals/shared/components/auth_screen_header.dart';
import 'package:locals/shared/components/auth_text_field.dart';
import 'package:locals/shared/components/password_requirement_box.dart';
import 'package:locals/shared/components/primary_button.dart';
import 'package:locals/shared/theme/app_colors.dart';
import '../controller/set_new_password_controller.dart';
import '../repository/set_new_password_repository.dart';
import 'widgets/password_changed_success_view.dart';
import 'widgets/set_new_password_login_link.dart';
import 'package:locals/core/localization/l10n_extensions.dart';

class SetNewPasswordScreen extends StatelessWidget {
  final String email;
  final String resetToken;

  const SetNewPasswordScreen({
    super.key,
    required this.email,
    required this.resetToken,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SetNewPasswordController(
        SetNewPasswordRepositoryImpl(),
        email: email,
        resetToken: resetToken,
      ),
      child: const _SetNewPasswordView(),
    );
  }
}

class _SetNewPasswordView extends StatelessWidget {
  const _SetNewPasswordView();

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<SetNewPasswordController>();

    if (controller.state.isSuccess) {
      return const Scaffold(body: PasswordChangedSuccessView());
    }

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AuthScreenHeader(
              title: context.l10n.setPasswordTitle,
              subtitle: context.l10n.setPasswordSubtitle,
            ),
            Padding(
              padding: EdgeInsets.all(24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AuthTextField(
                    label: context.l10n.setPasswordNewLabel,
                    hint: context.l10n.setPasswordNewHint,
                    prefixIcon: Icons.lock_outline,
                    obscureText: controller.state.obscureNewPassword,
                    onChanged: controller.setNewPassword,
                    suffix: IconButton(
                      onPressed: controller.toggleNewPasswordVisibility,
                      icon: Icon(
                        controller.state.obscureNewPassword
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        color: AppColors.primaryPink,
                        size: 20.sp,
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  AuthTextField(
                    label: context.l10n.setPasswordConfirmLabel,
                    hint: context.l10n.setPasswordConfirmHint,
                    prefixIcon: Icons.lock_outline,
                    obscureText: controller.state.obscureConfirmPassword,
                    onChanged: controller.setConfirmPassword,
                    suffix: IconButton(
                      onPressed: controller.toggleConfirmPasswordVisibility,
                      icon: Icon(
                        controller.state.obscureConfirmPassword
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        color: AppColors.primaryPink,
                        size: 20.sp,
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  PasswordRequirementBox(
                    requirements: SetNewPasswordController.passwordRequirements,
                  ),
                  if (controller.state.errorMessage != null) ...[
                    SizedBox(height: 12.h),
                    Text(
                      controller.state.errorMessage!,
                      style: TextStyle(
                        color: Colors.redAccent,
                        fontSize: 13.sp,
                      ),
                    ),
                  ],
                  SizedBox(height: 32.h),
                  PrimaryButton(
                    label: context.l10n.setPasswordButton,
                    onPressed: () {
                      if (!controller.state.isLoading) {
                        controller.resetPassword(context);
                      }
                    },
                  ),
                  SizedBox(height: 24.h),
                  SetNewPasswordLoginLink(
                    onTap: () => controller.goToLogin(context),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
