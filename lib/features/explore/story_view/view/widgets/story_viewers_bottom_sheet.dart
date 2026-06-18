import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:locals/features/explore/explore/model/explore_model.dart';
import 'package:locals/features/rank/view_profile/model/view_profile_args.dart';
import 'package:locals/shared/theme/app_colors.dart';
import 'package:locals/core/localization/l10n_extensions.dart';

class StoryViewersBottomSheet extends StatelessWidget {
  final List<StoryViewer> viewers;

  const StoryViewersBottomSheet({super.key, required this.viewers});

  static Future<void> show(BuildContext context, List<StoryViewer> viewers) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => StoryViewersBottomSheet(viewers: viewers),
    );
  }

  String _timeAgo(BuildContext context, DateTime time) {
    final diff = DateTime.now().difference(time);
    if (diff.inMinutes < 1) return context.l10n.storyJustNow;
    if (diff.inHours < 1) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    return '${diff.inDays}d ago';
  }

  void _openViewerProfile(BuildContext context, StoryViewer viewer) {
    if (viewer.id == 'you') return;

    Navigator.pop(context);
    context.push(
      '/view_profile',
      extra: ViewProfileArgs(userId: viewer.id),
    );
  }

  @override
  Widget build(BuildContext context) {
    final sorted = List<StoryViewer>.from(viewers)
      ..sort((a, b) => b.viewedAt.compareTo(a.viewedAt));

    return Container(
      constraints: BoxConstraints(maxHeight: MediaQuery.sizeOf(context).height * 0.55),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 12.h),
          Container(
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: AppColors.borderGray,
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20.w, 16.h, 12.w, 12.h),
            child: Row(
              children: [
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: Text(
                    context.l10n.storyViewersTitle,
                    style: TextStyle(
                      color: AppColors.black,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(
                    Icons.close,
                    color: AppColors.actionPink,
                    size: 22.sp,
                  ),
                ),
              ],
            ),
          ),
          if (sorted.isEmpty)
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 32.h),
              child: Text(
                context.l10n.storyViewersEmpty,
                style: TextStyle(
                  color: AppColors.levelGrey,
                  fontSize: 14.sp,
                ),
              ),
            )
          else
            Flexible(
              child: ListView.separated(
                shrinkWrap: true,
                padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 24.h),
                itemCount: sorted.length,
                separatorBuilder: (_, __) => Divider(
                  height: 1,
                  color: AppColors.borderGray.withValues(alpha: 0.5),
                ),
                itemBuilder: (context, index) {
                  final viewer = sorted[index];
                  return Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: viewer.id == 'you'
                          ? null
                          : () => _openViewerProfile(context, viewer),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 22.r,
                              backgroundColor: viewer.avatarColor,
                              child: Icon(
                                Icons.person,
                                color: AppColors.white.withValues(alpha: 0.85),
                                size: 22.sp,
                              ),
                            ),
                            SizedBox(width: 12.w),
                            Flexible(
                              flex: 1,
                              fit: FlexFit.tight,
                              child: Text(
                                viewer.name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: AppColors.black,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Text(
                              _timeAgo(context, viewer.viewedAt),
                              style: TextStyle(
                                color: AppColors.levelGrey,
                                fontSize: 13.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
