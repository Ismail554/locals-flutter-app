import 'package:locals/core/network/api_client.dart';

import '../model/terms_of_use_model.dart';

abstract class TermsOfUseRepository {
  Future<TermsOfUseModel> load();
}

class TermsOfUseRepositoryImpl implements TermsOfUseRepository {
  final ApiClient _client = ApiClient();


  @override
  Future<TermsOfUseModel> load() async {
    final response = await _client.get('/explore/legal/terms-of-use/');
    return TermsOfUseModel.fromJson(response);
  }
}
