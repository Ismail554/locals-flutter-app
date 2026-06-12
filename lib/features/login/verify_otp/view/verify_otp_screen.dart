import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:locals/shared/components/auth_screen_header.dart';
import 'package:locals/shared/components/neumorphic_back_button.dart';
import 'package:locals/shared/components/primary_button.dart';
import 'package:locals/shared/theme/app_colors.dart';
import '../controller/verify_otp_controller.dart';
import '../repository/verify_otp_repository.dart';
import 'widgets/otp_input_row.dart';
import 'widgets/verify_otp_hint_text.dart';
import 'widgets/verify_otp_resend_row.dart';

class VerifyOtpScreen extends StatelessWidget {
  const VerifyOtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => VerifyOtpController(VerifyOtpRepositoryImpl()),
      child: const _VerifyOtpView(),
    );
  }
}

class _VerifyOtpView extends StatelessWidget {
  const _VerifyOtpView();

  @override
  Widget build(BuildContext context) {
    final controller = context.read<VerifyOtpController>();

    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AuthScreenHeader(
            title: 'Reset your password',
            subtitle: 'Use the same mail that you used to create the account',
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(24.w, 24.h, 24.w, 0),
            child: NeumorphicBackButton(
              onPressed: () => controller.goBack(context),
            ),
          ),
          Flexible(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.all(24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Verify',
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
                  const VerifyOtpHintText(),
                  const Spacer(),
                  PrimaryButton(
                    label: 'Verify OTP',
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
