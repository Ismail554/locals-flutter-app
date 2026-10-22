import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:locals/core/network/api_client.dart';
import 'package:locals/core/media/image_save_service.dart';
import 'package:locals/features/map/map/model/map_mission_args.dart';
import '../../explore/model/explore_model.dart';
import '../../explore/repository/explore_repository.dart';
import '../../explore/service/story_upload_service.dart';
import '../model/share_card_args.dart';
import '../model/share_card_model.dart';
import '../repository/share_card_repository.dart';
import '../view/share_card_camera_screen.dart';
import 'package:locals/core/localization/l10n_extensions.dart';

enum ShareCardMediaSource { camera, gallery }

class ShareCardController extends ChangeNotifier {
  final ShareCardRepository repo;
  final ExploreRepository exploreRepo;
  final StoryUploadService storyUploadService;
  final ImageSaveService imageSaveService;
  final ShareCardArgs args;
  ShareCardModel state;

  /// Caption field controller — driven by the text field in the UI
  final TextEditingController captionController = TextEditingController();

  ShareCardController(
    this.repo,
    this.exploreRepo,
    this.args, {
    StoryUploadService? storyUploadService,
    ImageSaveService? imageSaveService,
  })  : storyUploadService = storyUploadService ?? StoryUploadService(),
        imageSaveService = imageSaveService ?? const ImageSaveService(),
        state = repo.load(args) {
    captionController.addListener(_onCaptionChanged);
  }

  void _onCaptionChanged() {
    state = state.copyWith(caption: captionController.text);
    notifyListeners();
  }

  Future<void> capturePhoto(BuildContext context) async {
    final imagePath = await Navigator.of(context, rootNavigator: true)
        .push<String>(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (_) => const ShareCardCameraScreen(),
      ),
    );

    if (imagePath == null) return;
    _applyImage(imagePath);
  }

  Future<void> retake(BuildContext context) async {
    state = state.copyWith(
      isConfirmed: false,
      clearImagePath: true,
      isSaved: false,
    );
    notifyListeners();
    await capturePhoto(context);
  }

  /// Submits the photo + caption as a real check-in
  /// (`POST /social/checkins/`) and updates level/points/city%/achievements
  /// from the live gamification response.
  Future<void> confirm(BuildContext context) async {
    if (state.imagePath == null || state.isSubmitting) return;

    final placeId = args.placeId;
    if (placeId == null || placeId.trim().isEmpty) {
      state = state.copyWith(
        submitError: 'This share card is not linked to a place.',
      );
      notifyListeners();
      return;
    }

    state = state.copyWith(isSubmitting: true, clearSubmitError: true);
    notifyListeners();

    try {
      final imageFile = File(state.imagePath!);
      if (!await imageFile.exists()) {
        throw const ApiException('The selected image is no longer available.');
      }

      final result = await repo.submitCheckIn(
        placeId: placeId,
        imagePath: imageFile,
        caption: state.caption.trim(),
      );

      state = state.copyWith(
        isConfirmed: result.success,
        isSubmitting: false,
        level: result.newLevel,
        points: result.newTotalPoints,
        cityPercent: result.cityCompletionPercentage.round(),
        unlockedAchievements: result.unlockedAchievements,
        submitError: result.success ? null : result.message,
        clearSubmitError: result.success,
      );
      notifyListeners();

      if (context.mounted && result.success &&
          result.unlockedAchievements.isNotEmpty) {
        final titles =
            result.unlockedAchievements.map((a) => a.title).join(', ');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Achievement unlocked: $titles')),
        );
      } else if (context.mounted && !result.success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(result.message)),
        );
      }
    } catch (error) {
      final message = error is ApiException
          ? error.message
          : 'Check-in failed. Please try again.';
      state = state.copyWith(isSubmitting: false, submitError: message);
      notifyListeners();
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message)),
        );
      }
    }
  }

  Future<void> addToStory(BuildContext context) async {
    if (state.imagePath != null) {
      await _uploadImageToStory(context, state.imagePath!);
      return;
    }

    final source = await _showMediaSourceSheet(context);
    if (!context.mounted || source == null) return;

    if (source == ShareCardMediaSource.camera) {
      await capturePhoto(context);
      if (!context.mounted || state.imagePath == null) return;
      await _uploadImageToStory(context, state.imagePath!);
    } else {
      try {
        final slide =
            await storyUploadService.pickAndUpload(context, exploreRepo);
        if (!context.mounted || slide == null) return;

        if (slide.imagePath != null) _applyImage(slide.imagePath!);
        exploreRepo.addSlideToYourStory(slide);
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Failed to upload story. Please try again.'),
            ),
          );
          return;
        }
      }
    }

  }

  Future<ShareCardMediaSource?> _showMediaSourceSheet(BuildContext context) {
    return showModalBottomSheet<ShareCardMediaSource>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (sheetContext) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.photo_camera_outlined),
              title: Text(sheetContext.l10n.shareCardTakePhoto),
              onTap: () =>
                  Navigator.pop(sheetContext, ShareCardMediaSource.camera),
            ),
            ListTile(
              leading: const Icon(Icons.photo_library_outlined),
              title: Text(sheetContext.l10n.shareCardChooseGallery),
              onTap: () =>
                  Navigator.pop(sheetContext, ShareCardMediaSource.gallery),
            ),
          ],
        ),
      ),
    );
  }

  void _applyImage(String imagePath) {
    state = state.copyWith(
      imagePath: imagePath,
      isConfirmed: false,
      isSaved: false,
    );
    notifyListeners();
  }

  Future<void> _uploadImageToStory(
    BuildContext context,
    String imagePath,
  ) async {
    try {
      final slide = await exploreRepo.uploadStory(File(imagePath));
      exploreRepo.addSlideToYourStory(slide);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(context.l10n.snackbarStoryAdded)),
        );
      }
    } catch (error) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to upload story: $error')),
        );
      }
    }
  }

  Future<void> saveImage(BuildContext context) async {
    final imagePath = state.imagePath;
    if (imagePath == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.l10n.snackbarCapturePhotoFirst)),
      );
      return;
    }

    if (state.isSaving) return;

    state = state.copyWith(isSaving: true);
    notifyListeners();

    final result = await imageSaveService.saveToGallery(context, imagePath);

    if (!context.mounted) return;

    state = state.copyWith(
      isSaving: false,
      isSaved: result == ImageSaveResult.success,
    );
    notifyListeners();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(result.message)),
    );
  }

  void done(BuildContext context) {
    final missionArgs = args.mapMissionArgs ?? _defaultMapMissionArgs();
    context.go('/map', extra: missionArgs);
  }

  MapMissionArgs _defaultMapMissionArgs() {
    return const MapMissionArgs(
      city: '',
      completedCount: 0,
      totalCount: 0,
      activeLocation: MapActiveLocation(
        locationId: '',
        category: '',
        seal: "",
        name: '',
        address: '',
        points: 0,
        imageColor: Color(0xFFD4C4B0), 
        latitude: 41.3833, 
        longitude: 2.1833,
      ),
    );
  }

  @override
  void dispose() {
    captionController.removeListener(_onCaptionChanged);
    captionController.dispose();
    super.dispose();
  }
}