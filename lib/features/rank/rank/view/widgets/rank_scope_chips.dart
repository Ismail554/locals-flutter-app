import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locals/shared/theme/app_colors.dart';
import '../../model/rank_model.dart';

class RankScopeChips extends StatelessWidget {
  final RankScope selected;
  final ValueChanged<RankScope> onChanged;

  const RankScopeChips({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  static const _labels = {
    RankScope.city: 'City',
    RankScope.country: 'Country',
    RankScope.global: 'Global',
    RankScope.followers: 'Followers',
  };

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: RankScope.values.map((scope) {
          final isSelected = scope == selected;
          return Padding(
            padding: EdgeInsets.only(right: 8.w),
            child: GestureDetector(
              onTap: () => onChanged(scope),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 8.h,
                ),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.black
                      : AppColors.chipUnselected,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  _labels[scope]!,
                  style: TextStyle(
                    color: isSelected
                        ? AppColors.white
                        : AppColors.textSecondary,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
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
