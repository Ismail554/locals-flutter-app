import 'dart:io';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

abstract final class GalleryPermission {
  static Future<bool> ensureGranted(BuildContext context) async {
    var status = await _resolvePermission().status;

    if (_isGranted(status)) {
      return true;
    }

    status = await _resolvePermission().request();

    if (_isGranted(status)) {
      return true;
    }

    if (Platform.isAndroid && status.isDenied) {
      final storageStatus = await Permission.storage.request();
      if (_isGranted(storageStatus)) {
        return true;
      }
      status = storageStatus;
    }

    if (!context.mounted) return false;

    if (status.isPermanentlyDenied) {
      final openSettings = await showDialog<bool>(
        context: context,
        builder: (dialogContext) => AlertDialog(
          title: const Text('Photo access required'),
          content: const Text(
            'Allow photo library access in Settings to add stories.',
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
    }

    return false;
  }

  static Permission _resolvePermission() {
    if (Platform.isIOS) {
      return Permission.photos;
    }
    return Permission.photos;
  }

  static bool _isGranted(PermissionStatus status) {
    return status.isGranted || status.isLimited;
  }
}
