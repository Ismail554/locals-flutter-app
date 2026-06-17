import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:locals/shared/theme/app_colors.dart';
import '../controller/story_view_controller.dart';
import '../model/story_view_args.dart';
import 'widgets/story_reaction_bar.dart';
import 'widgets/story_viewer_insights_bar.dart';
import 'widgets/story_slide_image.dart';
import 'widgets/story_viewer_header.dart';

class StoryViewScreen extends StatelessWidget {
  final StoryViewerArgs args;

  const StoryViewScreen({super.key, required this.args});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => StoryViewController(args),
      child: const _StoryViewBody(),
    );
  }
}

class _StoryViewBody extends StatefulWidget {
  const _StoryViewBody();

  @override
  State<_StoryViewBody> createState() => _StoryViewBodyState();
}

class _StoryViewBodyState extends State<_StoryViewBody> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<StoryViewController>().addListener(_onUpdate);
    });
  }

  void _onUpdate() {
    final controller = context.read<StoryViewController>();
    if (controller.isCompleted && mounted) {
      Navigator.of(context).pop();
    }
  }

  @override
  void dispose() {
    try {
      context.read<StoryViewController>().removeListener(_onUpdate);
    } catch (_) {}
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<StoryViewController>();
    final story = controller.currentStory;
    final slide = controller.currentSlide;

    return Scaffold(
      backgroundColor: AppColors.black,
      body: GestureDetector(
        onTapUp: (details) {
          final width = MediaQuery.sizeOf(context).width;
          if (details.globalPosition.dx < width * 0.35) {
            controller.onTapLeft();
          } else if (details.globalPosition.dx > width * 0.65) {
            controller.onTapRight();
          }
        },
        onLongPressStart: (_) => controller.pause(),
        onLongPressEnd: (_) => controller.resume(),
        child: Stack(
          fit: StackFit.expand,
          children: [
            StorySlideImage(slide: slide),
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppColors.black.withValues(alpha: 0.45),
                      Colors.transparent,
                      AppColors.black.withValues(alpha: 0.35),
                    ],
                    stops: const [0, 0.35, 1],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: SafeArea(
                bottom: false,
                child: StoryViewerHeader(
                  story: story,
                  slideIndex: controller.slideIndex,
                  progress: controller.slideProgress,
                  onClose: () => controller.close(context),
                ),
              ),
            ),
            if (controller.showHeartBurst)
              Center(
                child: Icon(
                  Icons.favorite,
                  color: AppColors.actionPink.withValues(alpha: 0.9),
                  size: 96.sp,
                ),
              ),
            if (controller.isYourStory)
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: SafeArea(
                  top: false,
                  child: StoryViewerInsightsBar(
                    viewerCount: controller.viewerCount,
                    onViewersTap: () => controller.openViewersSheet(context),
                    onDelete: () => controller.deleteCurrentSlide(context),
                  ),
                ),
              )
            else if (!controller.isYourStory)
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: SafeArea(
                  top: false,
                  child: StoryReactionBar(
                    isLiked: story.isLikedByMe,
                    likeCount: story.likeCount,
                    showHeartBurst: controller.showHeartBurst,
                    onHeartTap: controller.toggleHeart,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
