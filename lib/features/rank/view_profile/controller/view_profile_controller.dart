import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locals/shared/components/image_view/check_in_image_view.dart';
import 'package:locals/shared/components/image_view/image_view_dialog.dart';
import 'package:locals/shared/model/check_in_photo_model.dart';
import 'package:locals/shared/story/user_story_launcher.dart';
import '../model/view_profile_model.dart';
import '../repository/view_profile_repository.dart';
import 'package:locals/core/localization/l10n_extensions.dart';

class ViewProfileController extends ChangeNotifier {
  final ViewProfileRepository repo;
  ViewProfileModel state;

  ViewProfileController(this.repo, {String? userId})
    : state = repo
          .load(userId ?? 'marta')
          .copyWith(selectedTab: ViewProfileTab.map);

  bool get hasStory => UserStoryLauncher.hasStory(state.storyUserId);
  bool get isStoryViewed => UserStoryLauncher.isViewed(state.storyUserId);

  void selectTab(ViewProfileTab tab) {
    state = state.copyWith(selectedTab: tab);
    notifyListeners();
  }

  void toggleFollow() {
    state = state.copyWith(isFollowing: !state.isFollowing);
    notifyListeners();
  }

  void showMoreOptions(BuildContext context) {
    final box = context.findRenderObject() as RenderBox;
    final pos = box.localToGlobal(Offset.zero);

    showMenu(
      context: context,
      color: Colors.transparent,
      elevation: 0,
      constraints: BoxConstraints(minWidth: 90.w, maxWidth: 140.w),
      position: RelativeRect.fromLTRB(pos.dx + 50.w, pos.dy + 50.h, pos.dx, 0),
      items: [
        PopupMenuItem(
          value: 'block',
          padding: EdgeInsets.zero,
          height: 0,
          child: Container(
            constraints: BoxConstraints(minWidth: 90.w),
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: Color(0x33FF383C),
              borderRadius: BorderRadius.circular(24.r),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.block, color: Colors.red, size: 14.sp),

                SizedBox(width: 6.w),

                Flexible(
                  child: Text(
                    context.l10n.blockUserTitle,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ).then((value) {
      if (value == 'block') {
        blockUser(context);
      }
    });
  }

  void blockUser(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(context.l10n.blockUserTitle),
        content: Text(context.l10n.blockUserMessage(state.name)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(context.l10n.commonCancel),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('${state.name} has been blocked')),
              );
            },
            child: Text(
              context.l10n.blockUserConfirm,
              style: const TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  void openPhoto(BuildContext context, CheckInPhoto photo) {
    ImageViewDialog.show(context, photo, viewType: ImageViewType.checkIn);
  }

  Future<void> openStory(BuildContext context) async {
    final storyUserId = state.storyUserId;
    if (storyUserId == null || !hasStory) return;
    await UserStoryLauncher.open(context, storyUserId);
    notifyListeners();
  }
}
