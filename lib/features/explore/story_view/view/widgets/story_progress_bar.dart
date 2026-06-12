import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locals/shared/theme/app_colors.dart';

class StoryProgressBar extends StatelessWidget {
  final int slideCount;
  final int currentIndex;
  final double progress;

  const StoryProgressBar({
    super.key,
    required this.slideCount,
    required this.currentIndex,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(slideCount, (index) {
        final value = index < currentIndex
            ? 1.0
            : index == currentIndex
                ? progress.clamp(0.0, 1.0)
                : 0.0;

        return Flexible(
          flex: 1,
          fit: FlexFit.tight,
          child: Padding(
            padding: EdgeInsets.only(right: index < slideCount - 1 ? 4.w : 0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(2.r),
              child: LinearProgressIndicator(
                value: value,
                minHeight: 3.h,
                backgroundColor: AppColors.white.withValues(alpha: 0.3),
                color: AppColors.white,
              ),
            ),
          ),
        );
      }),
    );
  }
}
