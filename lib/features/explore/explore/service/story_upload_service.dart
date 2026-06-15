import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:locals/core/permissions/camera_permission.dart';
import 'package:locals/core/permissions/gallery_permission.dart';
import '../model/explore_model.dart';

class StoryUploadService {
  final ImagePicker _imagePicker;

  StoryUploadService({ImagePicker? imagePicker})
      : _imagePicker = imagePicker ?? ImagePicker();

  Future<StorySlide?> pickFromGallery(BuildContext context) async {
    final hasPermission = await GalleryPermission.ensureGranted(context);
    if (!hasPermission || !context.mounted) return null;

    final image = await _imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
    );
    if (image == null) return null;

    return StorySlide(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      imagePath: image.path,
      createdAt: DateTime.now(),
    );
  }

  Future<StorySlide?> pickFromCamera(BuildContext context) async {
    final hasPermission = await CameraPermission.ensureGranted(context);
    if (!hasPermission || !context.mounted) return null;

    final image = await _imagePicker.pickImage(
      source: ImageSource.camera,
      imageQuality: 85,
    );
    if (image == null) return null;

    return slideFromPath(image.path);
  }

  StorySlide slideFromPath(String path) {
    return StorySlide(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      imagePath: path,
      createdAt: DateTime.now(),
    );
  }
}
