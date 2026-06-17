import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locals/shared/model/check_in_photo_model.dart';
import 'package:locals/shared/theme/app_colors.dart';

class ProfileLatestVisitsSection extends StatelessWidget {
  final List<CheckInPhoto> visits;
  final ValueChanged<CheckInPhoto> onVisitTap;

  const ProfileLatestVisitsSection({
    super.key,
    required this.visits,
    required this.onVisitTap,
  });

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
            final visit = visits[index];
            return Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => onVisitTap(visit),
                borderRadius: BorderRadius.circular(12.r),
                child: Ink(
                  decoration: BoxDecoration(
                    color: visit.previewColor,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Icon(
                    Icons.image_outlined,
                    color: AppColors.white.withValues(alpha: 0.5),
                    size: 24.sp,
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
