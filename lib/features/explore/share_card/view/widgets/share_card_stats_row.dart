import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locals/shared/theme/app_colors.dart';

class ShareCardStatsRow extends StatelessWidget {
  final int level;
  final int points;
  final int cityPercent;

  const ShareCardStatsRow({
    super.key,
    required this.level,
    required this.points,
    required this.cityPercent,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          flex: 1,
          fit: FlexFit.tight,
          child: _StatItem(value: '$level', label: 'LEVEL'),
        ),
        Flexible(
          flex: 1,
          fit: FlexFit.tight,
          child: _StatItem(
            value: _formatPoints(points),
            label: 'POINTS',
          ),
        ),
        Flexible(
          flex: 1,
          fit: FlexFit.tight,
          child: _StatItem(value: '$cityPercent%', label: 'CITY'),
        ),
      ],
    );
  }

  String _formatPoints(int value) {
    final text = value.toString();
    if (value < 1000) return text;
    return '${text.substring(0, text.length - 3)},${text.substring(text.length - 3)}';
  }
}

class _StatItem extends StatelessWidget {
  final String value;
  final String label;

  const _StatItem({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            color: AppColors.black,
            fontSize: 22.sp,
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
    );
  }
}
