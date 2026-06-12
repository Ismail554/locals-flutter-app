import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locals/shared/theme/app_colors.dart';
import 'map_search_chip.dart';

class MapSearchSection extends StatelessWidget {
  final IconData icon;
  final String title;
  final List<String> items;
  final ValueChanged<String> onItemTap;

  const MapSearchSection({
    super.key,
    required this.icon,
    required this.title,
    required this.items,
    required this.onItemTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 16.sp, color: AppColors.levelGrey),
            SizedBox(width: 6.w),
            Text(
              title,
              style: TextStyle(
                color: AppColors.levelGrey,
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        Wrap(
          spacing: 8.w,
          runSpacing: 8.h,
          children: [
            for (final item in items)
              MapSearchChip(
                label: item,
                onTap: () => onItemTap(item),
              ),
          ],
        ),
      ],
    );
  }
}
