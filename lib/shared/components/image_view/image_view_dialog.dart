import 'package:flutter/material.dart';
import 'package:locals/shared/components/image_view/check_in_image_view.dart';
import 'package:locals/shared/model/check_in_photo_model.dart';
import 'package:locals/core/localization/l10n_extensions.dart';

class ImageViewDialog {
  ImageViewDialog._();

  static Future<void> show(BuildContext context, CheckInPhoto photo) {
    return showGeneralDialog<void>(
      context: context,
      barrierDismissible: true,
      barrierLabel: context.l10n.commonDismiss,
      barrierColor: Colors.black54,
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (context, animation, secondaryAnimation) {
        return CheckInImageView(
          photo: photo,
          onClose: () => Navigator.of(context).pop(),
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: Tween<double>(begin: 0.96, end: 1).animate(
              CurvedAnimation(parent: animation, curve: Curves.easeOut),
            ),
            child: child,
          ),
        );
      },
    );
  }
}
