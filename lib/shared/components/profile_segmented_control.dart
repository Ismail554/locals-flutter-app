import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locals/shared/theme/app_colors.dart';

class ProfileSegmentOption {
  final String label;
  final String value;

  const ProfileSegmentOption({required this.label, required this.value});
}

class ProfileSegmentedControl extends StatelessWidget {
  final List<ProfileSegmentOption> options;
  final String selectedValue;
  final ValueChanged<String> onChanged;

  const ProfileSegmentedControl({
    super.key,
    required this.options,
    required this.selectedValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44.h,
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppColors.chipUnselected,
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: Row(
        children: options.map((option) {
          final isSelected = option.value == selectedValue;
          return Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: GestureDetector(
              onTap: () => onChanged(option.value),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.white : Colors.transparent,
                  borderRadius: BorderRadius.circular(20.r),
                  boxShadow: isSelected
                      ? const [
                          BoxShadow(
                            color: AppColors.cardShadow,
                            blurRadius: 8,
                            offset: Offset(0, 2),
                          ),
                        ]
                      : null,
                ),
                child: Text(
                  option.label,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: isSelected ? AppColors.black : AppColors.textSecondary,
                    fontSize: 13.sp,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
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
