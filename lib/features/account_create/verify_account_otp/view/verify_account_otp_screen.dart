import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:locals/features/login/verify_otp/view/widgets/otp_input_row.dart';
import 'package:locals/features/login/verify_otp/view/widgets/verify_otp_resend_row.dart';
import 'package:locals/shared/components/auth_screen_header.dart';
import 'package:locals/shared/components/neumorphic_back_button.dart';
import 'package:locals/shared/components/primary_button.dart';
import 'package:locals/shared/theme/app_colors.dart';
import '../controller/verify_account_otp_controller.dart';
import '../repository/verify_account_otp_repository.dart';
import 'widgets/email_verified_success_view.dart';
import 'widgets/verify_account_otp_hint_text.dart';
import 'package:locals/core/localization/l10n_extensions.dart';

class VerifyAccountOtpScreen extends StatelessWidget {
  const VerifyAccountOtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => VerifyAccountOtpController(VerifyAccountOtpRepositoryImpl()),
      child: const _VerifyAccountOtpView(),
    );
  }
}

class _VerifyAccountOtpView extends StatelessWidget {
  const _VerifyAccountOtpView();

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<VerifyAccountOtpController>();

    if (controller.state.isSuccess) {
      return const Scaffold(
        body: EmailVerifiedSuccessView(),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AuthScreenHeader(
            title: context.l10n.signupTitle,
            subtitle: context.l10n.signupSubtitle,
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(24.w, 24.h, 24.w, 0),
            child: NeumorphicBackButton(
              onPressed: () => controller.goBack(context),
            ),
          ),
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: Padding(
              padding: EdgeInsets.all(24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.l10n.otpVerifyHeader,
                    style: TextStyle(
                      color: AppColors.black,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  OtpInputRow(
                    controllers: controller.digitControllers,
                    focusNodes: controller.focusNodes,
                    onDigitChanged: controller.onDigitChanged,
                  ),
                  SizedBox(height: 16.h),
                  const VerifyAccountOtpHintText(),
                  const Spacer(),
                  PrimaryButton(
                    label: context.l10n.otpVerifyButton,
                    onPressed: () => controller.verifyOtp(context),
                  ),
                  SizedBox(height: 20.h),
                  VerifyOtpResendRow(onResend: controller.resendCode),
                  SizedBox(height: 24.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
