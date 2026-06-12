import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locals/shared/theme/app_colors.dart';
import '../../model/explore_model.dart';
import 'explore_section_header.dart';
import 'explore_story_item.dart';

class ExploreRecentActivitySection extends StatelessWidget {
  final List<ExploreStory> stories;
  final ValueChanged<int> onStoryTap;

  const ExploreRecentActivitySection({
    super.key,
    required this.stories,
    required this.onStoryTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ExploreSectionHeader(
          icon: Icons.circle_outlined,
          title: 'RECENT ACTIVITY',
        ),
        SizedBox(height: 14.h),
        SizedBox(
          height: 92.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: stories.length,
            separatorBuilder: (_, __) => SizedBox(width: 12.w),
            itemBuilder: (context, index) {
              return ExploreStoryItem(
                story: stories[index],
                onTap: () => onStoryTap(index),
              );
            },
          ),
        ),
        SizedBox(height: 6.h),
        Divider(color: AppColors.borderGray.withValues(alpha: 0.6), height: 1),
      ],
    );
  }
}
