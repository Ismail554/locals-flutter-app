import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:locals/shared/components/auth_divider.dart';
import 'package:locals/shared/components/google_sign_in_button.dart';
import 'package:locals/shared/components/locals_logo.dart';
import 'package:locals/shared/components/primary_button.dart';
import 'package:locals/shared/theme/app_colors.dart';
import '../controller/signup_controller.dart';
import '../repository/signup_repository.dart';
import 'widgets/signup_form_fields.dart';
import 'widgets/signup_header.dart';
import 'widgets/signup_login_footer.dart';
import 'package:locals/core/localization/l10n_extensions.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SignupController(SignupRepositoryImpl()),
      child: const _SignupView(),
    );
  }
}

class _SignupView extends StatelessWidget {
  const _SignupView();

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<SignupController>();

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.fromLTRB(24.w, 56.h, 24.w, 32.h),
              decoration: BoxDecoration(
                color: AppColors.darkBackground,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(32.r),
                  bottomRight: Radius.circular(32.r),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const LocalsLogo(),
                  SizedBox(height: 24.h),
                  const SignupHeader(),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(24.w, 28.h, 24.w, 32.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SignupFormFields(
                    obscurePassword: controller.state.obscurePassword,
                    onNameChanged: controller.setName,
                    onEmailChanged: controller.setEmail,
                    onPasswordChanged: controller.setPassword,
                    onTogglePassword: controller.togglePasswordVisibility,
                  ),
                  SizedBox(height: 24.h),
                  PrimaryButton(
                    label: context.l10n.signupButton,
                    onPressed: () => controller.createAccount(context),
                  ),
                  SizedBox(height: 24.h),
                  const AuthDivider(),
                  SizedBox(height: 24.h),
                  GoogleSignInButton(
                    onPressed: () => controller.signInWithGoogle(context),
                  ),
                  SizedBox(height: 32.h),
                  SignupLoginFooter(
                    onLogin: () => controller.goToLogin(context),
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
