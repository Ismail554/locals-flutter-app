import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locals/shared/theme/app_colors.dart';
import '../../model/rank_model.dart';

class RankPeriodTabs extends StatelessWidget {
  final RankPeriod selected;
  final ValueChanged<RankPeriod> onSelected;

  const RankPeriodTabs({
    super.key,
    required this.selected,
    required this.onSelected,
  });

  static const _labels = {
    RankPeriod.weekly: 'Weekly',
    RankPeriod.monthly: 'Monthly',
    RankPeriod.allTime: 'All-time',
  };

  @override
  Widget build(BuildContext context) {
    return Row(
      children: RankPeriod.values.map((period) {
        final isSelected = period == selected;
        return Padding(
          padding: EdgeInsets.only(right: 16.w),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => onSelected(period),
              borderRadius: BorderRadius.circular(50.r),
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: isSelected ? 16.w : 0,
                  vertical: isSelected ? 10.h : 10.h,
                ),
                decoration: isSelected
                    ? ShapeDecoration(
                        color: AppColors.periodActiveBg,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.r),
                        ),
                      )
                    : null,
                child: Text(
                  _labels[period]!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: isSelected ? AppColors.actionPink : AppColors.black,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
