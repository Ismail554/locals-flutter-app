import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:locals/shared/components/profile_screen_header.dart';
import 'package:locals/shared/components/profile_segmented_control.dart';
import 'package:locals/shared/theme/app_colors.dart';
import '../controller/list_controller.dart';
import '../model/list_model.dart';
import '../repository/list_repository.dart';
import 'widgets/list_user_item.dart';
import 'package:locals/core/localization/l10n_extensions.dart';

class ListScreen extends StatelessWidget {
  const ListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ListController(ListRepositoryImpl()),
      child: const _ListView(),
    );
  }
}

class _ListView extends StatelessWidget {
  const _ListView();

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<ListController>();
    final state = controller.state;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 0),
              child: ProfileScreenHeader(
                title: context.l10n.listTitle,
                onBack: () => context.pop(),
                trailing:
                    Icon(Icons.more_horiz, color: AppColors.black, size: 24.sp),
              ),
            ),
            SizedBox(height: 16.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: ProfileSegmentedControl(
                options: [
                  ProfileSegmentOption(
                    label:
                        context.l10n.listFollowersCount(state.followersCount),
                    value: ListTab.followers.name,
                  ),
                  ProfileSegmentOption(
                    label:
                        context.l10n.listFollowingCount(state.followingCount),
                    value: ListTab.following.name,
                  ),
                ],
                selectedValue: state.selectedTab.name,
                onChanged: (value) =>
                    controller.selectTab(ListTab.values.byName(value)),
              ),
            ),
            SizedBox(height: 16.h),
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: state.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : state.errorMessage != null && state.activeUsers.isEmpty
                      ? Center(
                          child: Text(
                            state.errorMessage!,
                            style: TextStyle(
                              color: AppColors.levelGrey,
                              fontSize: 14.sp,
                            ),
                          ),
                        )
                      : RefreshIndicator(
                          onRefresh: controller.refresh,
                          child: ListView.separated(
                            padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 24.h),
                            itemCount: state.activeUsers.length,
                            separatorBuilder: (_, __) => SizedBox(height: 10.h),
                            itemBuilder: (context, index) {
                              final user = state.activeUsers[index];
                              return ListUserItem(
                                user: user,
                                tab: state.selectedTab,
                                hasStory: controller.hasStory(user.id),
                                isStoryViewed:
                                    controller.isStoryViewed(user.id),
                                onActionTap: () =>
                                    controller.toggleFollow(user.id),
                                onAvatarTap: () =>
                                    controller.openUserStory(context, user.id),
                                onProfileTap: () =>
                                    controller.openViewProfile(context),
                              );
                            },
                          ),
                        ),
            ),
          ],
        ),
      ),
    );
  }
}