import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NeumorphicIllustrationCard extends StatelessWidget {
  final Widget child;
  final double? size;
  final bool circular;

  const NeumorphicIllustrationCard({
    super.key,
    required this.child,
    this.size,
    this.circular = false,
  });

  @override
  Widget build(BuildContext context) {
    final cardSize = size ?? 170.w;
    final radius = circular ? cardSize / 2 : 22.67.r;

    return Container(
      width: cardSize,
      height: cardSize,
      padding: EdgeInsets.symmetric(horizontal: 28.33.w, vertical: 28.33.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment(-0.47, -0.43),
          end: Alignment(0.94, 0.98),
          colors: [Color(0xFFFFC9D5), Colors.white],
        ),
        borderRadius: BorderRadius.circular(radius),
        boxShadow: const [
          BoxShadow(
            color: Color(0x66EA4D70),
            blurRadius: 42.5,
            offset: Offset.zero,
            spreadRadius: 0,
          ),
          BoxShadow(
            color: Color(0x4CEA4D70),
            blurRadius: 21.25,
            offset: Offset(5.67, 11.33),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Center(child: child),
    );
  }
}
