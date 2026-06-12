import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:locals/shared/theme/app_colors.dart';

class ExploreYourStoryAvatar extends StatelessWidget {
  final double size;

  const ExploreYourStoryAvatar({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _DashedCirclePainter(
          fillColor: AppColors.chipUnselected,
          borderColor: AppColors.textSub2,
          strokeWidth: 1.5,
          dashLength: 5,
          dashGap: 4,
        ),
        child: Center(
          child: Icon(
            Icons.add_rounded,
            color: AppColors.actionPink,
            size: size * 0.38,
          ),
        ),
      ),
    );
  }
}

class _DashedCirclePainter extends CustomPainter {
  final Color fillColor;
  final Color borderColor;
  final double strokeWidth;
  final double dashLength;
  final double dashGap;

  const _DashedCirclePainter({
    required this.fillColor,
    required this.borderColor,
    required this.strokeWidth,
    required this.dashLength,
    required this.dashGap,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - strokeWidth;

    canvas.drawCircle(
      center,
      radius,
      Paint()..color = fillColor,
    );

    final borderPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final circumference = 2 * math.pi * radius;
    final dashCount =
        (circumference / (dashLength + dashGap)).floor().clamp(1, 999);

    for (var i = 0; i < dashCount; i++) {
      final startAngle = -math.pi / 2 + (i * (dashLength + dashGap)) / radius;
      final sweepAngle = dashLength / radius;
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        false,
        borderPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _DashedCirclePainter oldDelegate) {
    return fillColor != oldDelegate.fillColor ||
        borderColor != oldDelegate.borderColor ||
        strokeWidth != oldDelegate.strokeWidth;
  }
}
