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
    final imagePath = await Navigator.of(context, rootNavigator: true).push<String>(
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
      _addImageToStory(state.imagePath!);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Story added')),
        );
      }
      return;
    }

    final source = await _showMediaSourceSheet(context);
    if (!context.mounted || source == null) return;

    final StorySlide? slide;
    if (source == ShareCardMediaSource.camera) {
      slide = await _captureSlide(context);
    } else {
      slide = await storyUploadService.pickFromGallery(context);
    }

    if (!context.mounted || slide == null || slide.imagePath == null) return;

    _applyImage(slide.imagePath!);
    _addImageToStory(slide.imagePath!);

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Story added')),
      );
    }
  }

  Future<ShareCardMediaSource?> _showMediaSourceSheet(
    BuildContext context,
  ) {
    return showModalBottomSheet<ShareCardMediaSource>(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (sheetContext) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.photo_camera_outlined),
              title: const Text('Take photo'),
              onTap: () =>
                  Navigator.pop(sheetContext, ShareCardMediaSource.camera),
            ),
            ListTile(
              leading: const Icon(Icons.photo_library_outlined),
              title: const Text('Choose from gallery'),
              onTap: () =>
                  Navigator.pop(sheetContext, ShareCardMediaSource.gallery),
            ),
          ],
        ),
      ),
    );
  }

  Future<StorySlide?> _captureSlide(BuildContext context) async {
    await capturePhoto(context);
    final path = state.imagePath;
    if (path == null) return null;
    return storyUploadService.slideFromPath(path);
  }

  void _applyImage(String imagePath) {
    state = state.copyWith(
      imagePath: imagePath,
      isConfirmed: false,
      isSaved: false,
    );
    notifyListeners();
  }

  void _addImageToStory(String imagePath) {
    final slide = storyUploadService.slideFromPath(imagePath);
    exploreRepo.addSlideToYourStory(slide);
    state = state.copyWith(isConfirmed: true);
    notifyListeners();
  }

  Future<void> saveImage(BuildContext context) async {
    final imagePath = state.imagePath;
    if (imagePath == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Capture a photo first')),
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
