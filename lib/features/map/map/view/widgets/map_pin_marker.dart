import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locals/shared/model/map_pin_tag.dart';

class MapPinMarker extends StatelessWidget {
  final MapPinTag tag;
  final bool visited;

  const MapPinMarker({
    super.key,
    required this.tag,
    required this.visited,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      tag.assetPath(visited: visited),
      width: 40.w,
      height: 48.h,
      fit: BoxFit.contain,
    );
  }
}
