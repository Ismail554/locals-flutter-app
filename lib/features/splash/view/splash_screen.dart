import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/splash_controller.dart';
import '../repository/splash_repository.dart';
import 'widgets/splash_background.dart';
import 'widgets/splash_logo.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SplashController(SplashRepositoryImpl()),
      child: const _SplashView(),
    );
  }
}

class _SplashView extends StatelessWidget {
  const _SplashView();

  @override
  Widget build(BuildContext context) {
    final controller = context.read<SplashController>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.initialize(context);
    });

    return const Scaffold(
      body: SplashBackground(
        child: Center(
          child: SplashLogo(),
        ),
      ),
    );
  }
}
