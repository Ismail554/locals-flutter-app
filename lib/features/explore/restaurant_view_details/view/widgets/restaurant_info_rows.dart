import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locals/shared/theme/app_colors.dart';

class RestaurantInfoRows extends StatelessWidget {
  final String address;
  final String hours;
  final String instagramHandle;

  const RestaurantInfoRows({
    super.key,
    required this.address,
    required this.hours,
    required this.instagramHandle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _InfoRow(icon: Icons.location_on_outlined, text: address),
        SizedBox(height: 12.h),
        _InfoRow(icon: Icons.access_time_outlined, text: hours),
        SizedBox(height: 12.h),
        _InfoRow(icon: Icons.camera_alt_outlined, text: instagramHandle),
      ],
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const _InfoRow({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: AppColors.levelGrey, size: 20.sp),
        SizedBox(width: 12.w),
        Flexible(
          flex: 1,
          fit: FlexFit.tight,
          child: Text(
            text,
            style: TextStyle(
              color: AppColors.black,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
