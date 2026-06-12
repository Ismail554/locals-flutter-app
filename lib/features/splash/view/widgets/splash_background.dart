import 'package:flutter/material.dart';
import 'package:locals/shared/theme/app_colors.dart';

class SplashBackground extends StatelessWidget {
  final Widget child;

  const SplashBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: AppColors.darkBackground,
      child: child,
    );
  }
}
