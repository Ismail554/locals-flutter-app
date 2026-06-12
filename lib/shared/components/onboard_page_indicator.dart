import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locals/shared/theme/app_colors.dart';

class OnboardPageIndicator extends StatelessWidget {
  final int pageCount;
  final int currentIndex;

  const OnboardPageIndicator({
    super.key,
    required this.pageCount,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(pageCount, (index) {
        final isActive = index == currentIndex;
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 3.w),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut,
            width: isActive ? 18.w : 6.w,
            height: 6.h,
            decoration: ShapeDecoration(
              color: isActive
                  ? AppColors.actionPink
                  : AppColors.onboardGrey.withValues(alpha: 0.3),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(56.r),
              ),
            ),
          ),
        );
      }),
    );
  }
}
