import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locals/shared/theme/app_colors.dart';
import '../../model/missions_model.dart';

class MissionsFilterChips extends StatelessWidget {
  final MissionFilter selected;
  final ValueChanged<MissionFilter> onSelected;

  const MissionsFilterChips({
    super.key,
    required this.selected,
    required this.onSelected,
  });

  static const _labels = {
    MissionFilter.nearby: 'Nearby',
    MissionFilter.active: 'Active',
    MissionFilter.completed: 'Completed',
    MissionFilter.events: 'Events',
  };

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: MissionFilter.values.map((filter) {
          final isSelected = filter == selected;
          return Padding(
            padding: EdgeInsets.only(right: 8.w),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => onSelected(filter),
                borderRadius: BorderRadius.circular(20.r),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.chipSelected : AppColors.chipUnselected,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Text(
                    _labels[filter]!,
                    style: TextStyle(
                      color: isSelected ? AppColors.white : AppColors.black,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
