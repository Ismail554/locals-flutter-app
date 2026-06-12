import 'package:flutter/material.dart';
import 'package:locals/shared/theme/app_colors.dart';

class MapBackground extends StatelessWidget {
  const MapBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _MapBackgroundPainter(),
      size: Size.infinite,
    );
  }
}

class _MapBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final bg = Paint()..color = AppColors.mapBackground;
    canvas.drawRect(Offset.zero & size, bg);

    final zoneGreen = Paint()..color = AppColors.mapZoneGreen.withValues(alpha: 0.7);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(size.width * 0.05, size.height * 0.08, size.width * 0.35, size.height * 0.22),
        const Radius.circular(24),
      ),
      zoneGreen,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(size.width * 0.55, size.height * 0.58, size.width * 0.38, size.height * 0.28),
        const Radius.circular(24),
      ),
      zoneGreen,
    );

    final zoneBlue = Paint()..color = AppColors.mapZoneBlue.withValues(alpha: 0.75);
    final lakePath = Path()
      ..moveTo(size.width * 0.38, size.height * 0.32)
      ..quadraticBezierTo(size.width * 0.52, size.height * 0.28, size.width * 0.58, size.height * 0.35)
      ..quadraticBezierTo(size.width * 0.55, size.height * 0.48, size.width * 0.42, size.height * 0.46)
      ..quadraticBezierTo(size.width * 0.32, size.height * 0.42, size.width * 0.38, size.height * 0.32)
      ..close();
    canvas.drawPath(lakePath, zoneBlue);

    final road = Paint()
      ..color = AppColors.mapRoad
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.045
      ..strokeCap = StrokeCap.round;

    final roads = [
      Path()
        ..moveTo(0, size.height * 0.25)
        ..quadraticBezierTo(size.width * 0.5, size.height * 0.2, size.width, size.height * 0.3),
      Path()
        ..moveTo(size.width * 0.15, 0)
        ..quadraticBezierTo(size.width * 0.2, size.height * 0.5, size.width * 0.1, size.height),
      Path()
        ..moveTo(size.width * 0.55, 0)
        ..quadraticBezierTo(size.width * 0.5, size.height * 0.55, size.width * 0.6, size.height),
      Path()
        ..moveTo(0, size.height * 0.55)
        ..quadraticBezierTo(size.width * 0.45, size.height * 0.5, size.width, size.height * 0.6),
      Path()
        ..moveTo(size.width * 0.3, size.height * 0.15)
        ..lineTo(size.width * 0.75, size.height * 0.75),
    ];

    for (final path in roads) {
      canvas.drawPath(path, road);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
