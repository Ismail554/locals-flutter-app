import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locals/shared/theme/app_assets.dart';

class LocalsLogo extends StatelessWidget {
  final double? height;
  final bool useBlackLogo;

  const LocalsLogo({super.key, this.height, this.useBlackLogo = false});

  const LocalsLogo.black({super.key, this.height}) : useBlackLogo = true;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      useBlackLogo ? AppAssets.blackLogo : AppAssets.logo,
      height: height ?? 32.h,
      fit: BoxFit.contain,
    );
  }
}
