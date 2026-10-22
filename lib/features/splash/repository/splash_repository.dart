import 'package:locals/core/network/token_manager.dart';

abstract class SplashRepository {
  Future<bool> isLoggedIn();
}

class SplashRepositoryImpl implements SplashRepository {
  @override
  Future<bool> isLoggedIn() => TokenManager().hasToken;
}