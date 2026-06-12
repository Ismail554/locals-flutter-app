import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locals/shared/theme/app_colors.dart';
import '../../model/explore_model.dart';
import 'explore_ranking_row.dart';
import 'explore_section_header.dart';

class ExploreWeeklyRankingSection extends StatelessWidget {
  final List<ExploreRankingUser> users;
  final VoidCallback onSeeAll;

  const ExploreWeeklyRankingSection({
    super.key,
    required this.users,
    required this.onSeeAll,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ExploreSectionHeader(
          icon: Icons.trending_up,
          title: 'WEEKLY RANKING',
          actionLabel: 'See all',
          onAction: onSeeAll,
        ),
        SizedBox(height: 12.h),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
          decoration: BoxDecoration(
            color: AppColors.rankListItemBg,
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Column(
            children: [
              for (var i = 0; i < users.length; i++) ...[
                ExploreRankingRow(user: users[i]),
                if (i < users.length - 1)
                  Divider(
                    color: AppColors.borderGray.withValues(alpha: 0.5),
                    height: 1,
                  ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
