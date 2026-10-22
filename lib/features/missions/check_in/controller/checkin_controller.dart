import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../model/checkin_model.dart';
import '../repository/checkin_repository.dart';

class CheckInController extends ChangeNotifier {
  final CheckInRepository repo;
  final String placeId;

  CheckInController(this.repo, {required this.placeId});

  File? image;
  String caption = '';
  bool isSubmitting = false;
  String? errorMessage;
  CheckInResult? result;

  final _picker = ImagePicker();

  Future<void> pickImage(ImageSource source) async {
    final picked = await _picker.pickImage(
      source: source,
      imageQuality: 85,
      maxWidth: 1600,
    );
    if (picked != null) {
      image = File(picked.path);
      errorMessage = null;
      notifyListeners();
    }
  }

  void clearImage() {
    image = null;
    notifyListeners();
  }

  void updateCaption(String value) => caption = value;

  bool get canSubmit => image != null && !isSubmitting;

  Future<bool> submit() async {
    if (image == null || isSubmitting) return false;

    isSubmitting = true;
    errorMessage = null;
    notifyListeners();

    try {
      result = await repo.checkIn(
        placeId: placeId,
        image: image!,
        caption: caption.trim(),
      );
      isSubmitting = false;
      notifyListeners();
      return true;
    } catch (e) {
      errorMessage = e.toString();
      isSubmitting = false;
      notifyListeners();
      return false;
    }
  }
}