import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locals/shared/theme/app_colors.dart';
import '../../model/manage_subscription_model.dart';

class SubscriptionBillingSection extends StatelessWidget {
  final List<BillingHistoryItem> items;

  const SubscriptionBillingSection({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'BILLING HISTORY',
          style: TextStyle(
            color: AppColors.levelGrey,
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.8,
          ),
        ),
        SizedBox(height: 10.h),
        Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: AppColors.borderGray.withValues(alpha: 0.5)),
          ),
          child: Column(
            children: [
              for (var i = 0; i < items.length; i++) ...[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                  child: Row(
                    children: [
                      Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              items[i].title,
                              style: TextStyle(
                                color: AppColors.black,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              items[i].subtitle,
                              style: TextStyle(
                                color: AppColors.levelGrey,
                                fontSize: 12.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        items[i].amount,
                        style: TextStyle(
                          color: AppColors.black,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                if (i < items.length - 1)
                  Divider(
                    height: 1,
                    color: AppColors.borderGray.withValues(alpha: 0.5),
                  ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
