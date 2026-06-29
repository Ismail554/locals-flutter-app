import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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

  ShareCardController(
    this.repo,
    this.exploreRepo,
    this.args, {
    StoryUploadService? storyUploadService,
    ImageSaveService? imageSaveService,
  })  : storyUploadService = storyUploadService ?? StoryUploadService(),
        imageSaveService = imageSaveService ?? const ImageSaveService(),
        state = repo.load(args);

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

  void confirm() {
    if (state.imagePath == null) return;
    state = state.copyWith(isConfirmed: true);
    notifyListeners();
  }

  Future<void> addToStory(BuildContext context) async {
    if (state.imagePath != null) {
      // Already have an image — add it locally (no upload needed, it's a share card)
      _addLocalImageToStory(state.imagePath!);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(context.l10n.snackbarStoryAdded)),
        );
      }
      return;
    }

    final source = await _showMediaSourceSheet(context);
    if (!context.mounted || source == null) return;

    if (source == ShareCardMediaSource.camera) {
      // Camera: capture locally, add to story locally
      await capturePhoto(context);
      if (!context.mounted || state.imagePath == null) return;
      _addLocalImageToStory(state.imagePath!);
    } else {
      // Gallery: pick and upload to API, get server-backed slide
      try {
        final slide =
            await storyUploadService.pickAndUpload(context, exploreRepo);
        if (!context.mounted || slide == null) return;

        // If slide has a local path, reflect it in the share card UI
        if (slide.imagePath != null) _applyImage(slide.imagePath!);

        // Slide is already added to exploreRepo inside pickAndUpload → addSlideToYourStory
        // (StoryUploadService calls repo.uploadStory which returns the slide,
        //  then ExploreController calls repo.addSlideToYourStory — but here we
        //  call addSlideToYourStory directly since we bypass ExploreController)
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

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.l10n.snackbarStoryAdded)),
      );
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

  /// Add a local file path slide to your story without uploading to server.
  /// Used for camera captures and share card images.
  void _addLocalImageToStory(String imagePath) {
    final slide = storyUploadService.slideFromPath(imagePath);
    exploreRepo.addSlideToYourStory(slide);
    state = state.copyWith(isConfirmed: true);
    notifyListeners();
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
      city: 'Barcelona',
      completedCount: 5,
      totalCount: 35,
      activeLocation: MapActiveLocation(
        locationId: 'cafe_del_born',
        category: 'CAFE',
        seal: "locals' seal",
        name: 'Café del Born',
        address: 'Carrer del Born 12',
        points: 50,
        imageColor: Color(0xFFD4C4B0),
      ),
    );
  }
}