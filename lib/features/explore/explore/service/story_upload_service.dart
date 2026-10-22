import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:locals/core/permissions/camera_permission.dart';
import 'package:locals/core/permissions/gallery_permission.dart';
import '../model/explore_model.dart';
import '../repository/explore_repository.dart';

class StoryUploadService {
  final ImagePicker _imagePicker;

  StoryUploadService({ImagePicker? imagePicker})
      : _imagePicker = imagePicker ?? ImagePicker();

  /// Pick from gallery, upload to API, return the server-backed StorySlide.
  Future<StorySlide?> pickAndUpload(
    BuildContext context,
    ExploreRepository repo,
  ) async {
    final hasPermission = await GalleryPermission.ensureGranted(context);
    if (!hasPermission || !context.mounted) return null;

    final picked = await _imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
    );
    if (picked == null) return null;

    // Upload to server — repository handles the multipart request
    final slide = await repo.uploadStory(File(picked.path));
    return slide;
  }

  /// Pick from camera, upload to API, return the server-backed StorySlide.
  Future<StorySlide?> pickFromCameraAndUpload(
    BuildContext context,
    ExploreRepository repo,
  ) async {
    final hasPermission = await CameraPermission.ensureGranted(context);
    if (!hasPermission || !context.mounted) return null;

    final picked = await _imagePicker.pickImage(
      source: ImageSource.camera,
      imageQuality: 85,
    );
    if (picked == null) return null;

    return repo.uploadStory(File(picked.path));
  }

  // Keep local-only helpers for cases where upload isn't needed (offline, tests)
  StorySlide slideFromPath(String path) {
    return StorySlide(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      imagePath: path,
      createdAt: DateTime.now(),
    );
  }
}