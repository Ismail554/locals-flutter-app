import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:locals/core/localization/l10n_extensions.dart';
import 'package:locals/shared/theme/app_colors.dart';
import '../model/qr_checkin_result.dart';

class QRScanStatusScreen extends StatelessWidget {
  final QRCheckInResult result;

  const QRScanStatusScreen({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    final isSuccess = result.isSuccess;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 32.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                isSuccess ? Icons.check_circle : Icons.error_outline,
                size: 120.sp,
                color: isSuccess ? AppColors.actionPink : Colors.red,
              ),
              SizedBox(height: 32.h),
              Text(
                isSuccess ? context.l10n.qrVerified : context.l10n.qrScanFailed,
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 12.h),
              Text(
                result.message,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.sp,
                  color: AppColors.textSecondary,
                ),
              ),
              if (result.isTooFar) ...[
                SizedBox(height: 8.h),
                Text(
                  context.l10n.qrTooFar,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.red,
                  ),
                ),
              ],
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => context.pop(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.actionPink,
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                  ),
                  child: Text(
                    context.l10n.continueButton,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 40.h),
            ],
          ),
        ),
      ),
    );
  }
}