import '../model/edit_profile_model.dart';

abstract class EditProfileRepository {
  Future<EditProfileModel> load();
  Future<void> saveProfile({required String name, required String location});
  Future<bool> changePassword({
    required String currentPassword,
    required String newPassword,
  });
}

class EditProfileRepositoryImpl implements EditProfileRepository {
  @override
  Future<EditProfileModel> load() async => const EditProfileModel();

  @override
  Future<void> saveProfile({
    required String name,
    required String location,
  }) async {}

  @override
  Future<bool> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async =>
      currentPassword.isNotEmpty && newPassword.length >= 6;
}
