import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locals/shared/theme/app_colors.dart';
import 'package:locals/core/localization/l10n_extensions.dart';

class ViewProfileStatsRow extends StatelessWidget {
  final int visits;
  final int followers;
  final int cities;

  const ViewProfileStatsRow({
    super.key,
    required this.visits,
    required this.followers,
    required this.cities,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          flex: 1,
          fit: FlexFit.tight,
          child: _StatCard(value: '$visits', label: context.l10n.statVisits),
        ),
        SizedBox(width: 10.w),
        Flexible(
          flex: 1,
          fit: FlexFit.tight,
          child: _StatCard(value: '$followers', label: context.l10n.statFollowers),
        ),
        SizedBox(width: 10.w),
        Flexible(
          flex: 1,
          fit: FlexFit.tight,
          child: _StatCard(value: '$cities', label: context.l10n.statCities),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String value;
  final String label;

  const _StatCard({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      decoration: BoxDecoration(
        color: AppColors.chipUnselected,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              color: AppColors.black,
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            label,
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 10.sp,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}
