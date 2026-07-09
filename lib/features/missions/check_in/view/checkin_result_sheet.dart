import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locals/shared/theme/app_colors.dart';
import 'package:locals/core/localization/l10n_extensions.dart';
import '../model/checkin_model.dart';

Future<void> showCheckInResultSheet(BuildContext context, CheckInResult result) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    isDismissible: false,
    enableDrag: false,
    builder: (_) => _CheckInResultSheet(result: result),
  );
}

class _CheckInResultSheet extends StatelessWidget {
  final CheckInResult result;
  const _CheckInResultSheet({required this.result});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      padding: EdgeInsets.fromLTRB(20.w, 28.h, 20.w, 24.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 72.w,
            height: 72.w,
            decoration: const BoxDecoration(color: AppColors.actionPink, shape: BoxShape.circle),
            child: Icon(Icons.check, color: AppColors.white, size: 36.sp),
          ),
          SizedBox(height: 16.h),
          Text(context.l10n.checkInSuccessTitle,
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w700, color: AppColors.black)),
          SizedBox(height: 6.h),
          Text(context.l10n.checkInPointsEarned(result.pointsEarned),
              style: TextStyle(fontSize: 15.sp, color: AppColors.textSecondary)),
          if (result.missionCompleted) ...[
            SizedBox(height: 16.h),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 14.w),
              decoration: BoxDecoration(color: AppColors.chipSelected, borderRadius: BorderRadius.circular(14.r)),
              child: Row(
                children: [
                  Icon(Icons.emoji_events_outlined, color: AppColors.white, size: 20.sp),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Text(context.l10n.checkInMissionComplete,
                        style: TextStyle(color: AppColors.white, fontSize: 14.sp, fontWeight: FontWeight.w700)),
                  ),
                ],
              ),
            ),
          ],
          if (result.unlockedAchievements.isNotEmpty) ...[
            SizedBox(height: 20.h),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(context.l10n.checkInAchievementsUnlocked,
                  style: TextStyle(color: AppColors.levelGrey, fontSize: 12.sp, fontWeight: FontWeight.w600, letterSpacing: 0.5)),
            ),
            SizedBox(height: 10.h),
            ...result.unlockedAchievements.map((a) => Padding(
                  padding: EdgeInsets.only(bottom: 8.h),
                  child: Container(
                    padding: EdgeInsets.all(10.w),
                    decoration: BoxDecoration(color: AppColors.rankListItemBg, borderRadius: BorderRadius.circular(14.r)),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10.r),
                          child: Image.network(
                            a.iconUrl,
                            width: 40.w,
                            height: 40.w,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) =>
                                Icon(Icons.military_tech_outlined, size: 28.sp, color: AppColors.actionPink),
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Text(a.title,
                              style: TextStyle(color: AppColors.black, fontSize: 14.sp, fontWeight: FontWeight.w700)),
                        ),
                        Text('+${a.pointsAwarded}',
                            style: TextStyle(color: AppColors.actionPink, fontSize: 13.sp, fontWeight: FontWeight.w700)),
                      ],
                    ),
                  ),
                )),
          ],
          SizedBox(height: 20.h),
          SizedBox(
            width: double.infinity,
            height: 52.h,
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.actionPink,
                foregroundColor: AppColors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28.r)),
              ),
              child: Text(context.l10n.checkInContinue, style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700)),
            ),
          ),
        ],
      ),
    );
  }
}