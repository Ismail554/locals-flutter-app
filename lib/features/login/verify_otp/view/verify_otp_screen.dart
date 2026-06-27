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
import 'widgets/verify_otp_resend_row.dart';
import 'package:locals/core/localization/l10n_extensions.dart';

class VerifyOtpScreen extends StatelessWidget {

  final String email;

  const VerifyOtpScreen({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => VerifyOtpController(
        VerifyOtpRepositoryImpl(),
        email: email,
      ),
      child: const _VerifyOtpView(),
    );
  }
}

class _VerifyOtpView extends StatelessWidget {
  const _VerifyOtpView();

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<VerifyOtpController>();

    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AuthScreenHeader(
            title: context.l10n.otpResetPasswordTitle,
            subtitle: context.l10n.otpResetPasswordSubtitle,
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
                  const Spacer(),
                  PrimaryButton(
                    label: context.l10n.otpVerifyButton,
                    onPressed: () {
                      if (!controller.state.isLoading) {
                        controller.verifyOtp(context);
                      }
                    },
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