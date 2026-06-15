import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gal/gal.dart';
import 'package:permission_handler/permission_handler.dart';

class ImageSaveService {
  const ImageSaveService();

  Future<ImageSaveResult> saveToGallery(
    BuildContext context,
    String imagePath,
  ) async {
    final file = File(imagePath);
    if (!await file.exists()) {
      return ImageSaveResult.fileNotFound;
    }

    try {
      if (!await Gal.hasAccess(toAlbum: true)) {
        final granted = await Gal.requestAccess(toAlbum: true);
        if (!granted) {
          if (!context.mounted) return ImageSaveResult.permissionDenied;
          return await _handleDeniedPermission(context);
        }
      }

      await Gal.putImage(imagePath, album: 'Locals');
      return ImageSaveResult.success;
    } on GalException catch (error) {
      if (error.type == GalExceptionType.accessDenied && context.mounted) {
        return await _handleDeniedPermission(context);
      }
      return ImageSaveResult.failed;
    } catch (_) {
      return ImageSaveResult.failed;
    }
  }

  Future<ImageSaveResult> _handleDeniedPermission(
    BuildContext context,
  ) async {
    final openSettings = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Photo library access required'),
        content: const Text(
          'Allow photo library access in Settings to save images locally.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('Open Settings'),
          ),
        ],
      ),
    );

    if (openSettings == true) {
      await openAppSettings();
    }

    return ImageSaveResult.permissionDenied;
  }
}

enum ImageSaveResult {
  success,
  fileNotFound,
  permissionDenied,
  failed,
}

extension ImageSaveResultMessage on ImageSaveResult {
  String get message => switch (this) {
        ImageSaveResult.success => 'Image saved to your gallery',
        ImageSaveResult.fileNotFound => 'Image file not found',
        ImageSaveResult.permissionDenied => 'Photo library access denied',
        ImageSaveResult.failed => 'Could not save image',
      };
}
