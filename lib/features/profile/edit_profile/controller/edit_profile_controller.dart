import 'package:flutter/material.dart';
import 'package:locals/core/media/avatar_picker_service.dart';
import '../model/edit_profile_model.dart';
import '../repository/edit_profile_repository.dart';
import 'package:locals/core/localization/l10n_extensions.dart';

class EditProfileController extends ChangeNotifier {
  final EditProfileRepository repo;
  final AvatarPickerService avatarPickerService;
  EditProfileModel state = const EditProfileModel();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final locationController = TextEditingController();
  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool obscureCurrentPassword = true;
  bool obscureNewPassword = true;
  bool obscureConfirmPassword = true;
  bool isSaving = false;
  bool isChangingPassword = false;
  bool isPickingPhoto = false;

  EditProfileController(
    this.repo, {
    AvatarPickerService? avatarPickerService,
  }) : avatarPickerService = avatarPickerService ?? AvatarPickerService();

  Future<void> load() async {
    state = state.copyWith(isLoading: true);
    notifyListeners();

    final loaded = await repo.load();
    state = loaded.copyWith(isLoading: false);

    nameController.text = state.name;
    emailController.text = state.email;
    locationController.text = state.location;
    notifyListeners();
  }

  void toggleCurrentPasswordVisibility() {
    obscureCurrentPassword = !obscureCurrentPassword;
    notifyListeners();
  }

  void toggleNewPasswordVisibility() {
    obscureNewPassword = !obscureNewPassword;
    notifyListeners();
  }

  void toggleConfirmPasswordVisibility() {
    obscureConfirmPassword = !obscureConfirmPassword;
    notifyListeners();
  }

  Future<void> saveChanges(BuildContext context) async {
    if (isSaving) return;
    isSaving = true;
    notifyListeners();

    try {
      await repo.saveProfile(
        name: nameController.text.trim(),
        location: locationController.text.trim(),
        avatarImagePath: state.avatarImagePath,
      );

      state = state.copyWith(
        name: nameController.text.trim(),
        location: locationController.text.trim(),
      );

      isSaving = false;
      notifyListeners();

      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.l10n.snackbarProfileUpdated)),
      );
    } catch (e) {
      isSaving = false;
      notifyListeners();

      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to update profile. Please try again.'),
        ),
      );
    }
  }

  Future<void> changePassword(BuildContext context) async {
    if (isChangingPassword) return;

    final current = currentPasswordController.text;
    final newPass = newPasswordController.text;
    final confirm = confirmPasswordController.text;

    if (newPass != confirm) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.l10n.snackbarPasswordsNoMatch)),
      );
      return;
    }

    isChangingPassword = true;
    notifyListeners();

    final success = await repo.changePassword(
      currentPassword: current,
      newPassword: newPass,
    );

    isChangingPassword = false;
    notifyListeners();

    if (!context.mounted) return;

    if (success) {
      currentPasswordController.clear();
      newPasswordController.clear();
      confirmPasswordController.clear();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.l10n.snackbarPasswordChanged)),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.l10n.snackbarPasswordChangeFailed)),
      );
    }
  }

  Future<void> changePhoto(BuildContext context) async {
    if (isPickingPhoto) return;

    isPickingPhoto = true;
    notifyListeners();

    final imagePath = await avatarPickerService.pickFromGallery(context);

    isPickingPhoto = false;

    if (imagePath != null) {
      state = state.copyWith(avatarImagePath: imagePath);
    }

    notifyListeners();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    locationController.dispose();
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}