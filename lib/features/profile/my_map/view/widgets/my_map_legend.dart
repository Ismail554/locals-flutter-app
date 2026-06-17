import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locals/shared/theme/app_assets.dart';
import 'package:locals/shared/theme/app_colors.dart';

class MyMapLegend extends StatelessWidget {
  const MyMapLegend({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        _LegendItem(
          assetPath: AppAssets.visitedBusiness,
          label: 'Visited',
        ),
        SizedBox(width: 16.w),
        _LegendItem(
          assetPath: AppAssets.unvisitedBusiness,
          label: 'Unvisited',
        ),
      ],
    );
  }
}

class _LegendItem extends StatelessWidget {
  final String assetPath;
  final String label;

  const _LegendItem({required this.assetPath, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          assetPath,
          width: 18.w,
          height: 22.h,
          fit: BoxFit.contain,
        ),
        SizedBox(width: 6.w),
        Text(
          label,
          style: TextStyle(
            color: AppColors.levelGrey,
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
