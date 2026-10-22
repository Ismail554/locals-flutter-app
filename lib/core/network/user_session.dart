import 'package:flutter/foundation.dart';
import 'package:locals/core/network/api_client.dart';
import 'package:locals/features/profile/edit_profile/model/user_model.dart';


class UserSession extends ChangeNotifier {
  static final UserSession _instance = UserSession._internal();

  factory UserSession() => _instance;

  UserSession._internal();

  final ApiClient _client = ApiClient();

  UserModel? _currentUser;

  UserModel? get currentUser => _currentUser;

  bool get isLoaded => _currentUser != null;

  Future<UserModel?> fetchCurrentUser() async {
    try {
      final response = await _client.get('/auth/me/');
      _currentUser = UserModel.fromApi(response);
      notifyListeners();
      return _currentUser;
    } catch (e) {
      print('UserSession fetch error: $e');
      return null;
    }
  }

  void updateCachedUser(UserModel updated) {
    _currentUser = updated;
    notifyListeners();
  }

  void clear() {
    _currentUser = null;
    notifyListeners();
  }
}