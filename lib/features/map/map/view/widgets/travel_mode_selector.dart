import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locals/shared/theme/app_colors.dart';

import '../../model/travel_mode.dart';

/// Compact floating pill that lets the user switch the active route between
/// walk / car / bus. Styled to match the existing map controls (white,
/// rounded, soft shadow) so it blends into the current design.
class TravelModeSelector extends StatelessWidget {
  final TravelMode selected;
  final ValueChanged<TravelMode> onSelected;

  const TravelModeSelector({
    super.key,
    required this.selected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: const [
          BoxShadow(
            color: AppColors.cardShadow,
            blurRadius: 16,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _ModeButton(
            icon: Icons.directions_walk,
            isSelected: selected == TravelMode.walk,
            onTap: () => onSelected(TravelMode.walk),
          ),
          _ModeButton(
            icon: Icons.directions_car,
            isSelected: selected == TravelMode.car,
            onTap: () => onSelected(TravelMode.car),
          ),
          _ModeButton(
            icon: Icons.directions_bus,
            isSelected: selected == TravelMode.bus,
            onTap: () => onSelected(TravelMode.bus),
          ),
        ],
      ),
    );
  }
}

class _ModeButton extends StatelessWidget {
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _ModeButton({
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(20.r),
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.actionPink : Colors.transparent,
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Icon(
            icon,
            size: 22.sp,
            color: isSelected ? AppColors.white : AppColors.levelGrey,
          ),
        ),
      ),
    );
  }
}
