import '../model/terms_of_use_model.dart';

abstract class TermsOfUseRepository {
  Future<TermsOfUseModel> load();
}

class TermsOfUseRepositoryImpl implements TermsOfUseRepository {
  @override
  Future<TermsOfUseModel> load() async => const TermsOfUseModel();
}
