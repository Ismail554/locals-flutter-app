import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locals/shared/theme/app_colors.dart';
import '../../model/mission_details_model.dart';
import 'package:locals/core/localization/l10n_extensions.dart';

class MissionDetailsHeaderCard extends StatelessWidget {
  final MissionDetailsModel mission;

  const MissionDetailsHeaderCard({super.key, required this.mission});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF3D3D45), Color(0xFF2D2D34)],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 44.w,
            height: 44.w,
            decoration: const BoxDecoration(
              color: AppColors.actionPink,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.adjust, color: AppColors.white, size: 22.sp),
          ),
          SizedBox(height: 16.h),
          Text(
            mission.title,
            style: TextStyle(
              color: AppColors.white,
              fontSize: 24.sp,
              fontWeight: FontWeight.w700,
              height: 1.2,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            mission.description,
            style: TextStyle(
              color: AppColors.white.withValues(alpha: 0.75),
              fontSize: 14.sp,
              height: 1.4,
            ),
          ),
          SizedBox(height: 20.h),
          Row(
            children: [
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: _InfoBox(
                  label: context.l10n.statReward,
                  value: '+${mission.reward}',
                ),
              ),
              SizedBox(width: 10.w),
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: _InfoBox(
                  label: context.l10n.statStops,
                  value: '${mission.totalStops}',
                ),
              ),
              SizedBox(width: 10.w),
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: _InfoBox(
                  label: context.l10n.statLevel,
                  value: mission.level,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _InfoBox extends StatelessWidget {
  final String label;
  final String value;

  const _InfoBox({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: AppColors.white.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              color: AppColors.white.withValues(alpha: 0.55),
              fontSize: 10.sp,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            value,
            style: TextStyle(
              color: AppColors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
