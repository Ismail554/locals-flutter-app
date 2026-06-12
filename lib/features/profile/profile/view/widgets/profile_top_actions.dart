import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locals/shared/theme/app_colors.dart';

class ProfileTopActions extends StatelessWidget {
  final VoidCallback onShare;
  final VoidCallback onSettings;

  const ProfileTopActions({
    super.key,
    required this.onShare,
    required this.onSettings,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        _ActionCircle(icon: Icons.ios_share, onTap: onShare),
        SizedBox(width: 10.w),
        _ActionCircle(icon: Icons.settings_outlined, onTap: onSettings),
      ],
    );
  }
}

class _ActionCircle extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _ActionCircle({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(22.r),
        child: Container(
          width: 44.w,
          height: 44.w,
          decoration: BoxDecoration(
            color: AppColors.chipUnselected,
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 20.sp, color: AppColors.black),
        ),
      ),
    );
  }
}
