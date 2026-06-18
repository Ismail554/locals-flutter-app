import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:locals/shared/components/auth_divider.dart';
import 'package:locals/shared/components/google_sign_in_button.dart';
import 'package:locals/shared/components/locals_logo.dart';
import 'package:locals/shared/components/primary_button.dart';
import 'package:locals/shared/theme/app_colors.dart';
import '../controller/login_controller.dart';
import '../repository/login_repository.dart';
import 'widgets/login_form_fields.dart';
import 'widgets/login_options_row.dart';
import 'widgets/login_signup_footer.dart';
import 'widgets/login_welcome_header.dart';
import 'package:locals/core/localization/l10n_extensions.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LoginController(LoginRepositoryImpl()),
      child: const _LoginView(),
    );
  }
}

class _LoginView extends StatelessWidget {
  const _LoginView();

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<LoginController>();

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
                  const LoginWelcomeHeader(),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(24.w, 28.h, 24.w, 32.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LoginFormFields(
                    obscurePassword: controller.state.obscurePassword,
                    onEmailChanged: controller.setEmail,
                    onPasswordChanged: controller.setPassword,
                    onTogglePassword: controller.togglePasswordVisibility,
                  ),
                  SizedBox(height: 16.h),
                  LoginOptionsRow(
                    rememberMe: controller.state.rememberMe,
                    onRememberChanged: controller.toggleRememberMe,
                    onForgotPassword: () => controller.goToForgotPassword(context),
                  ),
                  SizedBox(height: 24.h),
                  PrimaryButton(
                    label: context.l10n.loginButton,
                    onPressed: () => controller.login(context),
                  ),
                  SizedBox(height: 24.h),
                  const AuthDivider(),
                  SizedBox(height: 24.h),
                  GoogleSignInButton(onPressed: () => controller.login(context)),
                  SizedBox(height: 32.h),
                  LoginSignupFooter(
                    onCreateAccount: () => controller.goToSignup(context),
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
