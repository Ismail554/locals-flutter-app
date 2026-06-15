import 'package:flutter/material.dart';
import '../model/edit_profile_model.dart';
import '../repository/edit_profile_repository.dart';

class EditProfileController extends ChangeNotifier {
  final EditProfileRepository repo;
  EditProfileModel state = const EditProfileModel();

  final nameController = TextEditingController();
  final locationController = TextEditingController();
  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool obscureCurrentPassword = true;
  bool obscureNewPassword = true;
  bool obscureConfirmPassword = true;
  bool isSaving = false;
  bool isChangingPassword = false;

  EditProfileController(this.repo);

  Future<void> load() async {
    state = await repo.load();
    nameController.text = state.name;
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

    await repo.saveProfile(
      name: nameController.text.trim(),
      location: locationController.text.trim(),
    );

    state = state.copyWith(
      name: nameController.text.trim(),
      location: locationController.text.trim(),
    );

    isSaving = false;
    notifyListeners();

    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Profile updated')),
    );
  }

  Future<void> changePassword(BuildContext context) async {
    if (isChangingPassword) return;

    final current = currentPasswordController.text;
    final newPass = newPasswordController.text;
    final confirm = confirmPasswordController.text;

    if (newPass != confirm) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Passwords do not match')),
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
        const SnackBar(content: Text('Password changed')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not change password')),
      );
    }
  }

  void changePhoto() {
    // Placeholder for image picker integration.
  }

  @override
  void dispose() {
    nameController.dispose();
    locationController.dispose();
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}
