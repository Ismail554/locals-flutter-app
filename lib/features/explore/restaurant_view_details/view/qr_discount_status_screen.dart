import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:locals/shared/theme/app_colors.dart';
import '../model/qr_discount_result.dart';

class QRDiscountStatusScreen extends StatelessWidget {
  final QRDiscountResult result;

  const QRDiscountStatusScreen({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    final discount = result.discount;
    final isSuccess = result.success && discount != null;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 32.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                isSuccess ? Icons.local_offer : Icons.error_outline,
                size: 120.sp,
                color: isSuccess ? AppColors.actionPink : Colors.red,
              ),
              SizedBox(height: 32.h),
              Text(
                isSuccess ? 'Discount Claimed!' : 'Unable to Claim Discount',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 12.h),
              if (isSuccess) ...[
                Text(
                  discount.title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  discount.description,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: AppColors.textSecondary,
                  ),
                ),
                if (result.pointsSpent != null) ...[
                  SizedBox(height: 12.h),
                  Text(
                    '${result.pointsSpent} points spent',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ] else
                Text(
                  result.message,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: AppColors.textSecondary,
                  ),
                ),
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
                    'Done',
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