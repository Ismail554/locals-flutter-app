import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locals/shared/theme/app_colors.dart';

class ProfileActionGrid extends StatelessWidget {
  final VoidCallback onMyMap;
  final VoidCallback onFollowers;
  final VoidCallback onSavedPlace;
  final VoidCallback onBlocked;

  const ProfileActionGrid({
    super.key,
    required this.onMyMap,
    required this.onFollowers,
    required this.onSavedPlace,
    required this.onBlocked,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: _ActionPill(icon: Icons.location_on_outlined, label: 'My Map', onTap: onMyMap),
            ),
            SizedBox(width: 10.w),
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: _ActionPill(icon: Icons.people_outline, label: 'Followers', onTap: onFollowers),
            ),
          ],
        ),
        SizedBox(height: 10.h),
        Row(
          children: [
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: _ActionPill(icon: Icons.bookmark_outline, label: 'Saved place', onTap: onSavedPlace),
            ),
            SizedBox(width: 10.w),
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: _ActionPill(icon: Icons.block_outlined, label: 'Blocked', onTap: onBlocked),
            ),
          ],
        ),
      ],
    );
  }
}

class _ActionPill extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ActionPill({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24.r),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
          decoration: BoxDecoration(
            color: AppColors.chipUnselected,
            borderRadius: BorderRadius.circular(24.r),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 18.sp, color: AppColors.black),
              SizedBox(width: 6.w),
              Flexible(
                child: Text(
                  label,
                  style: TextStyle(
                    color: AppColors.black,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
