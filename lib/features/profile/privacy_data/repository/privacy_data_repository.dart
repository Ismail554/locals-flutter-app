import '../model/privacy_data_model.dart';

abstract class PrivacyDataRepository {
  Future<PrivacyDataModel> load();
  Future<void> deleteAccount();
}

class PrivacyDataRepositoryImpl implements PrivacyDataRepository {
  @override
  Future<PrivacyDataModel> load() async => const PrivacyDataModel();

  @override
  Future<void> deleteAccount() async {}
}
