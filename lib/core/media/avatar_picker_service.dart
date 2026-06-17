import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:locals/core/permissions/gallery_permission.dart';

class AvatarPickerService {
  final ImagePicker _imagePicker;

  AvatarPickerService({ImagePicker? imagePicker})
      : _imagePicker = imagePicker ?? ImagePicker();

  Future<String?> pickFromGallery(BuildContext context) async {
    final hasPermission = await GalleryPermission.ensureGranted(context);
    if (!hasPermission || !context.mounted) return null;

    final image = await _imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
    );

    return image?.path;
  }
}
