import 'package:flutter/foundation.dart';
import '../model/terms_of_use_model.dart';
import '../repository/terms_of_use_repository.dart';

class TermsOfUseController extends ChangeNotifier {
  final TermsOfUseRepository repo;
  TermsOfUseModel state = const TermsOfUseModel();

  TermsOfUseController(this.repo);

  Future<void> load() async {
    state = await repo.load();
    notifyListeners();
  }
}
