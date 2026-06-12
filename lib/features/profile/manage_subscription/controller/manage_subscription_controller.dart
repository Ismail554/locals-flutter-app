import 'package:flutter/foundation.dart';
import '../model/manage_subscription_model.dart';
import '../repository/manage_subscription_repository.dart';

class ManageSubscriptionController extends ChangeNotifier {
  final ManageSubscriptionRepository repo;
  ManageSubscriptionModel state = const ManageSubscriptionModel();

  ManageSubscriptionController(this.repo);

  void setAutoRenew(bool value) {
    state = state.copyWith(autoRenew: value);
    notifyListeners();
  }
}
