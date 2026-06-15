import '../model/help_support_model.dart';

abstract class HelpSupportRepository {
  Future<HelpSupportModel> load();
  Future<void> sendSupportEmail({
    required String subject,
    required String message,
  });
}

class HelpSupportRepositoryImpl implements HelpSupportRepository {
  @override
  Future<HelpSupportModel> load() async => const HelpSupportModel();

  @override
  Future<void> sendSupportEmail({
    required String subject,
    required String message,
  }) async {}
}
