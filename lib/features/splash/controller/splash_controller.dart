import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../model/splash_model.dart';
import '../repository/splash_repository.dart';

class SplashController extends ChangeNotifier {
  final SplashRepository repo;
  SplashModel state = const SplashModel();

  SplashController(this.repo);

  bool _hasStarted = false;

  Future<void> initialize(BuildContext context) async {
    if (_hasStarted) return;
    _hasStarted = true;
    await Future<void>.delayed(const Duration(seconds: 2));
    if (!context.mounted) return;
    context.go('/onboard');
  }
}
