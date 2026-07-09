import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:locals/shared/theme/app_colors.dart';
import '../controller/rank_controller.dart';
import '../repository/rank_repository.dart';
import 'widgets/rank_list_item.dart';
import 'widgets/rank_period_tabs.dart';
import 'widgets/rank_podium.dart';
import 'widgets/rank_scope_chips.dart';
import 'package:locals/core/localization/l10n_extensions.dart';

class RankScreen extends StatelessWidget {
  const RankScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RankController(RankRepositoryImpl()),
      child: const _RankView(),
    );
  }
}

class _RankView extends StatelessWidget {
  const _RankView();

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<RankController>();
    final state = controller.state;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: controller.isLoading && state.podium.isEmpty
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 16.h),
                      child: Text(
                        context.l10n.rankLeaderboardTitle,
                        style: TextStyle(
                          color: AppColors.black,
                          fontSize: 26.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: RankScopeChips(
                        selected: state.selectedScope,
                        onChanged: controller.selectScope,
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(child: SizedBox(height: 12.h)),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: RankPeriodTabs(
                        selected: state.selectedPeriod,
                        onSelected: controller.selectPeriod,
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(child: SizedBox(height: 24.h)),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: RankPodium(
                        users: state.podium,
                        hasStory: (user) => controller.hasStory(user.storyUserId),
                        isStoryViewed: (user) =>
                            controller.isStoryViewed(user.storyUserId),
                        onUserTap: (_) => controller.openViewProfile(context),
                        onAvatarTap: (user) =>
                            controller.onPodiumAvatarTap(context, user),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(child: SizedBox(height: 24.h)),
                  SliverPadding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final entry = state.entries[index];
                          return RankListItem(
                            entry: entry,
                            hasStory: controller.hasStory(entry.storyUserId),
                            isStoryViewed:
                                controller.isStoryViewed(entry.storyUserId),
                            onTap: entry.isCurrentUser
                                ? null
                                : () => controller.openViewProfile(context),
                            onAvatarTap: () =>
                                controller.onListAvatarTap(context, entry),
                          );
                        },
                        childCount: state.entries.length,
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(child: SizedBox(height: 24.h)),
                ],
              ),
      ),
    );
  }
}