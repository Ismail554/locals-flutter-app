import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:locals/features/missions/check_in/view/checkin_result_sheet.dart';
import 'package:provider/provider.dart';
import 'package:locals/shared/theme/app_colors.dart';
import 'package:locals/core/localization/l10n_extensions.dart';
import '../controller/checkin_controller.dart';
import '../repository/checkin_repository.dart';
import '../model/checkin_model.dart';

Future<CheckInResult?> showCheckInSheet(
  BuildContext context, {
  required String placeId,
  required String placeName,
}) async {
  final result = await showModalBottomSheet<CheckInResult>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => ChangeNotifierProvider(
      create: (_) =>
          CheckInController(CheckInRepositoryImpl(), placeId: placeId),
      child: _CheckInSheet(placeName: placeName),
    ),
  );

  if (result != null && context.mounted) {
    await showCheckInResultSheet(context, result);
  }
  return result;
}

class _CheckInSheet extends StatelessWidget {
  final String placeName;
  const _CheckInSheet({required this.placeName});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<CheckInController>();

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        ),
        padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 24.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: AppColors.chipUnselected,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              context.l10n.checkInTitle,
              style: TextStyle(
                color: AppColors.black,
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              placeName,
              style: TextStyle(color: AppColors.textSecondary, fontSize: 14.sp),
            ),
            SizedBox(height: 16.h),
            _PhotoPicker(
              image: controller.image,
              onTap: () => _pickImage(context),
            ),
            SizedBox(height: 16.h),
            TextField(
              onChanged: controller.updateCaption,
              maxLines: 3,
              maxLength: 200,
              decoration: InputDecoration(
                hintText: context.l10n.checkInCaptionHint,
                filled: true,
                fillColor: AppColors.rankListItemBg,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14.r),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            if (controller.errorMessage != null) ...[
              SizedBox(height: 8.h),
              Text(
                controller.errorMessage!,
                style: TextStyle(color: Colors.red, fontSize: 12.sp),
              ),
            ],
            SizedBox(height: 8.h),
            SizedBox(
              width: double.infinity,
              height: 52.h,
              child: ElevatedButton(
                onPressed: controller.canSubmit ? () => _submit(context) : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.actionPink,
                  foregroundColor: AppColors.white,
                  disabledBackgroundColor: AppColors.chipUnselected,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28.r),
                  ),
                ),
                child: controller.isSubmitting
                    ? SizedBox(
                        width: 22.w,
                        height: 22.w,
                        child: const CircularProgressIndicator(
                          color: AppColors.white,
                          strokeWidth: 2.5,
                        ),
                      )
                    : Text(
                        context.l10n.checkInSubmit,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickImage(BuildContext context) async {
    final controller = context.read<CheckInController>();
    final source = await showModalBottomSheet<ImageSource>(
      context: context,
      backgroundColor: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (_) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt_outlined),
              title: Text(context.l10n.checkInCamera),
              onTap: () => Navigator.pop(context, ImageSource.camera),
            ),
            ListTile(
              leading: const Icon(Icons.photo_library_outlined),
              title: Text(context.l10n.checkInGallery),
              onTap: () => Navigator.pop(context, ImageSource.gallery),
            ),
          ],
        ),
      ),
    );
    if (source != null) await controller.pickImage(source);
  }

  Future<void> _submit(BuildContext context) async {
    final controller = context.read<CheckInController>();
    final success = await controller.submit();
    if (success && context.mounted) {
      Navigator.pop(context, controller.result);
    }
  }
}

class _PhotoPicker extends StatelessWidget {
  final File? image;
  final VoidCallback onTap;
  const _PhotoPicker({required this.image, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 180.h,
        decoration: BoxDecoration(
          color: AppColors.rankListItemBg,
          borderRadius: BorderRadius.circular(16.r),
          image: image != null
              ? DecorationImage(image: FileImage(image!), fit: BoxFit.cover)
              : null,
        ),
        child: image == null
            ? Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.add_a_photo_outlined,
                      size: 28.sp,
                      color: AppColors.levelGrey,
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      context.l10n.checkInAddPhoto,
                      style: TextStyle(
                        color: AppColors.levelGrey,
                        fontSize: 13.sp,
                      ),
                    ),
                  ],
                ),
              )
            : null,
      ),
    );
  }
}
