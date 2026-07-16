import 'package:flutter/foundation.dart';
import '../model/terms_of_use_model.dart';
import '../repository/terms_of_use_repository.dart';

class TermsOfUseController extends ChangeNotifier {
  final TermsOfUseRepository repo;
  TermsOfUseModel state = TermsOfUseModel();

  bool isLoading = true;

  TermsOfUseController(this.repo){
    load();
  }

  Future<void> load() async {
    isLoading = true;
    notifyListeners();
    try {
      state = await repo.load();
    } catch (e) {
      debugPrint('Terms of use load error: $e');
    }
    isLoading = false;
    notifyListeners();
  }
}
