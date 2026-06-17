import '../model/edit_profile_model.dart';

abstract class EditProfileRepository {
  Future<EditProfileModel> load();
  Future<void> saveProfile({
    required String name,
    required String location,
    String? avatarImagePath,
  });
  Future<bool> changePassword({
    required String currentPassword,
    required String newPassword,
  });
}

class EditProfileRepositoryImpl implements EditProfileRepository {
  EditProfileModel _profile = const EditProfileModel();

  @override
  Future<EditProfileModel> load() async => _profile;

  @override
  Future<void> saveProfile({
    required String name,
    required String location,
    String? avatarImagePath,
  }) async {
    _profile = _profile.copyWith(
      name: name,
      location: location,
      avatarImagePath: avatarImagePath,
    );
  }

  @override
  Future<bool> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async =>
      currentPassword.isNotEmpty && newPassword.length >= 6;
}
