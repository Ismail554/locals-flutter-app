import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locals/shared/theme/app_assets.dart';

class LocalsLogo extends StatelessWidget {
  final double? height;

  const LocalsLogo({super.key, this.height});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      AppAssets.logo,
      height: height ?? 32.h,
      fit: BoxFit.contain,
    );
  }
}
