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

class SetNewPasswordScreen extends StatelessWidget {
  const SetNewPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SetNewPasswordController(SetNewPasswordRepositoryImpl()),
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
      return const Scaffold(
        body: PasswordChangedSuccessView(),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AuthScreenHeader(
              title: 'Create a new password',
              subtitle: 'Create something unique but rememberable',
            ),
            Padding(
              padding: EdgeInsets.all(24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AuthTextField(
                    label: 'New Password',
                    hint: 'Something secure',
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
                    label: 'Confirm Password',
                    hint: 'Confirm your password',
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
                  SizedBox(height: 32.h),
                  PrimaryButton(
                    label: 'Reset Password',
                    onPressed: () => controller.resetPassword(context),
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
