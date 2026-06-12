import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locals/shared/theme/app_colors.dart';

class BottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  const BottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onSelected,
  });

  static const _items = [
    _NavItem(Icons.map_outlined, 'Map'),
    _NavItem(Icons.explore_outlined, 'Explore'),
    _NavItem(Icons.adjust_outlined, 'Missions'),
    _NavItem(Icons.emoji_events_outlined, 'Rank'),
    _NavItem(Icons.account_circle_outlined, 'Profile'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.r),
          topRight: Radius.circular(16.r),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 16.r,
            offset: Offset(0, -4.h),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 72.h,
          width: double.infinity,
          child: Row(
            children: List.generate(_items.length, (index) {
              final item = _items[index];
              final isSelected = index == selectedIndex;
              final color = isSelected ? AppColors.navActive : AppColors.navInactive;

              return Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () => onSelected(index),
                    borderRadius: BorderRadius.only(
                      topLeft: index == 0 ? Radius.circular(16.r) : Radius.zero,
                      topRight: index == _items.length - 1
                          ? Radius.circular(16.r)
                          : Radius.zero,
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            item.icon,
                            color: color,
                            size: 26.sp,
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            item.label,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: color,
                              fontSize: 12.sp,
                              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                              height: 1.2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

class _NavItem {
  final IconData icon;
  final String label;

  const _NavItem(this.icon, this.label);
}
