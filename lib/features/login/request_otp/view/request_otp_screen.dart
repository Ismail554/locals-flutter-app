import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:locals/shared/components/auth_screen_header.dart';
import 'package:locals/shared/components/neumorphic_back_button.dart';
import 'package:locals/shared/components/primary_button.dart';
import 'package:locals/shared/theme/app_colors.dart';
import '../controller/request_otp_controller.dart';
import '../repository/request_otp_repository.dart';
import 'widgets/request_otp_form.dart';
import 'package:locals/core/localization/l10n_extensions.dart';
class RequestOtpScreen extends StatelessWidget {
  const RequestOtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RequestOtpController(RequestOtpRepositoryImpl()),
      child: const _RequestOtpView(),
    );
  }
}

class _RequestOtpView extends StatelessWidget {
  const _RequestOtpView();

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<RequestOtpController>();

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
            child: Padding(
              padding: EdgeInsets.all(24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RequestOtpForm(onEmailChanged: controller.setEmail),
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
                    label: context.l10n.requestOtpButton,
                    isLoading: controller.state.isLoading,
                    onPressed: () {
                      if (!controller.state.isLoading) {
                        controller.requestOtp(context);
                      }
                    },
                  ),
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