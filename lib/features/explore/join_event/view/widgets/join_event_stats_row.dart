import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locals/shared/theme/app_colors.dart';

class JoinEventStatsRow extends StatelessWidget {
  final String stops;
  final String reward;
  final String progress;

  const JoinEventStatsRow({
    super.key,
    required this.stops,
    required this.reward,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          flex: 1,
          fit: FlexFit.tight,
          child: _StatCard(value: stops, label: 'STOPS'),
        ),
        SizedBox(width: 10.w),
        Flexible(
          flex: 1,
          fit: FlexFit.tight,
          child: _StatCard(value: reward, label: 'REWARD'),
        ),
        SizedBox(width: 10.w),
        Flexible(
          flex: 1,
          fit: FlexFit.tight,
          child: _StatCard(value: progress, label: 'PROGRESS'),
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
