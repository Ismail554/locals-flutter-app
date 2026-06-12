import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../model/explore_model.dart';
import 'explore_follow_card.dart';
import 'explore_section_header.dart';

class ExploreFollowLocalsSection extends StatelessWidget {
  final List<ExploreFollowUser> users;
  final List<ExploreStory> stories;
  final ValueChanged<String> onFollowTap;
  final VoidCallback onCardTap;
  final ValueChanged<String> onAvatarTap;
  final VoidCallback onSeeAll;

  const ExploreFollowLocalsSection({
    super.key,
    required this.users,
    required this.stories,
    required this.onFollowTap,
    required this.onCardTap,
    required this.onAvatarTap,
    required this.onSeeAll,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ExploreSectionHeader(
          icon: Icons.person_add_outlined,
          title: 'FIND LOCALS TO FOLLOW',
          actionLabel: 'See all',
          onAction: onSeeAll,
        ),
        SizedBox(height: 12.h),
        SizedBox(
          height: 196.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: users.length,
            separatorBuilder: (_, __) => SizedBox(width: 12.w),
            itemBuilder: (context, index) {
              final user = users[index];
              final storyIndex =
                  stories.indexWhere((story) => story.id == user.id);
              final story = storyIndex >= 0 ? stories[storyIndex] : null;
              final hasStory = story != null && story.hasStory;

              return SizedBox(
                width: 132.w,
                child: ExploreFollowCard(
                  user: user,
                  story: hasStory ? story : null,
                  onCardTap: onCardTap,
                  onAvatarTap: () => onAvatarTap(user.id),
                  onFollowTap: () => onFollowTap(user.id),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
