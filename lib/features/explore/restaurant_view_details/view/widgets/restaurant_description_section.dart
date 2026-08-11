import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locals/shared/theme/app_colors.dart';
import 'package:locals/core/localization/l10n_extensions.dart';

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
          isExpanded ? fullDescription : shortDescription,
          maxLines: isExpanded ? null : 2,
          overflow: isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
          style: TextStyle(
            color: AppColors.black,
            fontSize: 14.sp,
            height: 1.5,
          ),
        ),
        SizedBox(height: 8.h),
        GestureDetector(
          onTap: onToggle,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                isExpanded
                    ? context.l10n.commonShowLess
                    : context.l10n.commonShowMore,
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
