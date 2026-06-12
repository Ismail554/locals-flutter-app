import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locals/shared/theme/app_colors.dart';
import '../../model/profile_model.dart';

class ProfileLatestVisitsSection extends StatelessWidget {
  final List<ProfileVisitTile> visits;

  const ProfileLatestVisitsSection({super.key, required this.visits});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Latest visits',
          style: TextStyle(
            color: AppColors.black,
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 12.h),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 8.w,
            mainAxisSpacing: 8.h,
            childAspectRatio: 1,
          ),
          itemCount: visits.length,
          itemBuilder: (context, index) {
            return Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: visits[index].color,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                Icons.image_outlined,
                color: AppColors.white.withValues(alpha: 0.5),
                size: 24.sp,
              ),
            );
          },
        ),
      ],
    );
  }
}
