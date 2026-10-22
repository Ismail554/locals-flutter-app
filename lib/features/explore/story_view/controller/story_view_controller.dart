import 'dart:async';

import 'package:flutter/material.dart';
import 'package:locals/features/explore/explore/repository/explore_repository.dart';
import '../../explore/model/explore_model.dart';
import '../model/story_view_args.dart';
import '../view/widgets/story_viewers_bottom_sheet.dart';
import 'package:locals/core/localization/l10n_extensions.dart';

class StoryViewController extends ChangeNotifier {
  final StoryViewerArgs args;
  final ExploreRepository repo;

  late final List<ExploreStory> stories;
  late int storyIndex;
  int slideIndex = 0;
  double slideProgress = 0;
  bool isPaused = false;
  bool showHeartBurst = false;
  bool isCompleted = false;

  Timer? _timer;
  static const _slideDuration = Duration(seconds: 5);
  static const _tick = Duration(milliseconds: 50);

  StoryViewController(this.args, this.repo) {
    stories = args.stories
        .where((s) => s.hasStory)
        .map((s) => s.copyWith(slides: s.activeSlides))
        .toList();
    storyIndex = args.initialStoryIndex.clamp(0, stories.length - 1);
    if (!isYourStory) {
      _recordCurrentUserAsViewer();
    }
    _startTimer();
  }

  List<StorySlide> get _currentSlides => currentStory.activeSlides;

  ExploreStory get currentStory => stories[storyIndex];
  StorySlide get currentSlide => _currentSlides[slideIndex];
  bool get isYourStory => currentStory.isYourStory;
  int get viewerCount => currentStory.displayViewerCount;

  static const _currentUserViewerId = 'you';
  static const _currentUserViewerName = 'You';

  void _startTimer() {
    _timer?.cancel();
    slideProgress = 0;
    _timer = Timer.periodic(_tick, (_) {
      if (isPaused || isCompleted) return;
      slideProgress += _tick.inMilliseconds / _slideDuration.inMilliseconds;
      if (slideProgress >= 1) {
        _goNext();
      } else {
        notifyListeners();
      }
    });
  }

  void pause() {
    isPaused = true;
    notifyListeners();
  }

  void resume() {
    isPaused = false;
    notifyListeners();
  }

  void _goNext() {
    if (slideIndex < _currentSlides.length - 1) {
      slideIndex++;
      _markViewed();
      _startTimer();
      notifyListeners();
      return;
    }
    if (storyIndex < stories.length - 1) {
      storyIndex++;
      slideIndex = 0;
      _markViewed();
      _startTimer();
      notifyListeners();
      return;
    }
    _finish();
  }

  void _goPrevious() {
    if (slideIndex > 0) {
      slideIndex--;
      _startTimer();
      notifyListeners();
      return;
    }
    if (storyIndex > 0) {
      storyIndex--;
      slideIndex = stories[storyIndex].activeSlides.length - 1;
      _startTimer();
      notifyListeners();
    }
  }

  void onTapLeft() => _goPrevious();

  void onTapRight() => _goNext();

  Future<void> toggleHeart() async {
    if (isYourStory) return;

    final slide = currentSlide;

    final newLikeStatus = !slide.isLikedByMe;

    // optimistic update
    final updatedSlide = slide.copyWith(
      isLikedByMe: newLikeStatus,
      likeCount: newLikeStatus ? slide.likeCount + 1 : slide.likeCount - 1,
    );

    final updatedSlides = List<StorySlide>.from(currentStory.slides);

    updatedSlides[slideIndex] = updatedSlide;

    stories[storyIndex] = currentStory.copyWith(slides: updatedSlides);

    showHeartBurst = newLikeStatus;

    notifyListeners();

    try {
      final liked = await repo.likeStory(slide.id);

      // update API result
      final apiUpdatedSlide = updatedSlide.copyWith(isLikedByMe: liked);

      final apiSlides = List<StorySlide>.from(currentStory.slides);

      apiSlides[slideIndex] = apiUpdatedSlide;

      stories[storyIndex] = currentStory.copyWith(slides: apiSlides);

      notifyListeners();
    } catch (e) {
      // rollback
      final rollbackSlides = List<StorySlide>.from(currentStory.slides);

      rollbackSlides[slideIndex] = slide;

      stories[storyIndex] = currentStory.copyWith(slides: rollbackSlides);

      notifyListeners();

      debugPrint("Story like error: $e");
    }

    if (newLikeStatus) {
      Future.delayed(const Duration(milliseconds: 600), () {
        showHeartBurst = false;
        notifyListeners();
      });
    }
  }

  void _markViewed() {
    if (!isYourStory) {
      _recordCurrentUserAsViewer();
    }
    if (currentStory.isViewed) return;
    stories[storyIndex] = currentStory.copyWith(isViewed: true);
  }

  void _recordCurrentUserAsViewer() {
    final story = currentStory;
    if (story.viewers.any((viewer) => viewer.id == _currentUserViewerId)) {
      return;
    }

    stories[storyIndex] = story.copyWith(
      viewers: [
        StoryViewer(
          id: _currentUserViewerId,
          name: _currentUserViewerName,
          viewedAt: DateTime.now(),
          avatarColor: const Color(0xFF9BB5CE),
        ),
        ...story.viewers,
      ],
      isViewed: true,
    );
  }

  Future<void> openViewersSheet(BuildContext context) async {
    if (!isYourStory) return;

    pause();
    await StoryViewersBottomSheet.show(context, currentStory.viewers);
    resume();
  }

  Future<void> deleteCurrentSlide(BuildContext context) async {
    if (!isYourStory) return;

    pause();
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        final l10n = dialogContext.l10n;
        return AlertDialog(
          title: Text(l10n.storyDeletePhotoTitle),
          content: Text(l10n.storyDeletePhotoMessage),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, false),
              child: Text(l10n.commonCancel),
            ),
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, true),
              child: Text(
                l10n.commonDelete,
                style: TextStyle(color: Colors.red.shade700),
              ),
            ),
          ],
        );
      },
    );
    resume();

    if (confirmed != true || !context.mounted) return;

    final slides = List<StorySlide>.from(_currentSlides)..removeAt(slideIndex);

    if (slides.isEmpty) {
      stories[storyIndex] = currentStory.copyWith(slides: [], viewers: []);
      _syncBack();
      if (context.mounted) Navigator.of(context).pop();
      return;
    }

    stories[storyIndex] = currentStory.copyWith(slides: slides);
    if (slideIndex >= slides.length) {
      slideIndex = slides.length - 1;
    }
    _syncBack();
    _startTimer();
    notifyListeners();
  }

  void close(BuildContext context) {
    _syncBack();
    Navigator.of(context).pop();
  }

  void _finish() {
    _markViewed();
    _syncBack();
    isCompleted = true;
    _timer?.cancel();
    notifyListeners();
  }

  void _syncBack() {
    final updatedMap = {for (final s in stories) s.id: s};
    final merged = args.stories.map((s) => updatedMap[s.id] ?? s).toList();
    args.onStoriesUpdated?.call(merged);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
