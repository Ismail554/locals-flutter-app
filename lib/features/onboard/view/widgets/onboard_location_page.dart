import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locals/shared/components/neumorphic_illustration_card.dart';
import 'package:locals/shared/theme/app_colors.dart';
import '../../model/onboard_model.dart';

class OnboardLocationPage extends StatelessWidget {
  final OnboardPageData page;

  const OnboardLocationPage({super.key, required this.page});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 100.w,
          height: 100.w,
          child: Image.asset(
            page.imageAsset,
            fit: BoxFit.contain,
          ),
        ),
        SizedBox(height: 20.h),
        Text(
          page.title,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColors.white,
            fontSize: 30.sp,
            fontWeight: FontWeight.w700,
            height: 1.45,
            letterSpacing: 1.8,
          ),
        ),
        SizedBox(height: 30.h),
        Text(
          page.subtitle,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColors.onboardGrey,
            fontSize: 18.sp,
            fontWeight: FontWeight.w400,
            height: 1.45,
            letterSpacing: 1.08,
          ),
        ),
      ],
    );
  }
}
