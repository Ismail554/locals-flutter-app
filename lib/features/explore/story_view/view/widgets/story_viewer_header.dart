import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locals/shared/theme/app_colors.dart';
import '../../../explore/model/explore_model.dart';
import 'story_progress_bar.dart';

class StoryViewerHeader extends StatelessWidget {
  final ExploreStory story;
  final int slideIndex;
  final double progress;
  final VoidCallback onClose;

  const StoryViewerHeader({
    super.key,
    required this.story,
    required this.slideIndex,
    required this.progress,
    required this.onClose,
  });

  String _timeAgo(DateTime time) {
    final diff = DateTime.now().difference(time);
    if (diff.inHours < 1) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    return '${diff.inDays}d ago';
  }

  @override
  Widget build(BuildContext context) {
    final slide = story.slides[slideIndex];

    return Padding(
      padding: EdgeInsets.fromLTRB(12.w, 8.h, 12.w, 0),
      child: Column(
        children: [
          StoryProgressBar(
            slideCount: story.slides.length,
            currentIndex: slideIndex,
            progress: progress,
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(1.5.w),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.actionPink, width: 1.5),
                ),
                child: CircleAvatar(
                  radius: 16.r,
                  backgroundColor: AppColors.chipUnselected,
                  child: Icon(
                    Icons.person,
                    size: 18.sp,
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      story.name,
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      _timeAgo(slide.createdAt),
                      style: TextStyle(
                        color: AppColors.white.withValues(alpha: 0.75),
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: onClose,
                icon: Icon(Icons.close, color: AppColors.white, size: 24.sp),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
