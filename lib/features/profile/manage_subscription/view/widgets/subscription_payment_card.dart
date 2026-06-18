import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locals/shared/theme/app_colors.dart';
import 'package:locals/core/localization/l10n_extensions.dart';

class SubscriptionPaymentCard extends StatelessWidget {
  final String paymentMethod;
  final String paymentExpiry;

  const SubscriptionPaymentCard({
    super.key,
    required this.paymentMethod,
    required this.paymentExpiry,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.borderGray.withValues(alpha: 0.5)),
      ),
      child: Row(
        children: [
          Icon(Icons.credit_card_outlined,
              color: AppColors.actionPink, size: 22.sp),
          SizedBox(width: 12.w),
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  paymentMethod,
                  style: TextStyle(
                    color: AppColors.black,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  paymentExpiry,
                  style: TextStyle(
                    color: AppColors.levelGrey,
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
          ),
          Text(
            context.l10n.subscriptionUpdatePayment,
            style: TextStyle(
              color: AppColors.actionPink,
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
