import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locals/shared/theme/app_colors.dart';

class RestaurantDescriptionSection extends StatelessWidget {
  final String shortDescription;
  final String fullDescription;
  final bool isExpanded;
  final VoidCallback onToggle;

  const RestaurantDescriptionSection({
    super.key,
    required this.shortDescription,
    required this.fullDescription,
    required this.isExpanded,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          shortDescription,
          style: TextStyle(
            color: AppColors.black,
            fontSize: 15.sp,
            fontWeight: FontWeight.w700,
            height: 1.4,
          ),
        ),
        if (isExpanded) ...[
          SizedBox(height: 8.h),
          Text(
            fullDescription,
            style: TextStyle(
              color: AppColors.textSub2,
              fontSize: 14.sp,
              height: 1.5,
            ),
          ),
        ],
        SizedBox(height: 8.h),
        GestureDetector(
          onTap: onToggle,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                isExpanded ? 'Show less' : 'Show more',
                style: TextStyle(
                  color: AppColors.actionPink,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Icon(
                isExpanded
                    ? Icons.keyboard_arrow_up
                    : Icons.keyboard_arrow_down,
                color: AppColors.actionPink,
                size: 20.sp,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
