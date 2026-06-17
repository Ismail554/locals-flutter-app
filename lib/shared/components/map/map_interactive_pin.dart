import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locals/features/map/map/view/widgets/map_pin_marker.dart';
import 'package:locals/shared/components/map/map_pin_callout.dart';
import 'package:locals/shared/model/map_pin_info.dart';

class MapInteractivePin extends StatelessWidget {
  final MapPinInfo pin;
  final bool isSelected;
  final VoidCallback onTap;

  static const double pinHeight = 48;
  static const double pinWidth = 40;

  const MapInteractivePin({
    super.key,
    required this.pin,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.translucent,
      child: SizedBox(
        width: pinWidth.w,
        height: pinHeight.h,
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.bottomCenter,
          children: [
            if (isSelected)
              Positioned(
                bottom: pinHeight.h + 4.h,
                child: MapPinCallout(name: pin.name, level: pin.level),
              ),
            MapPinMarker(tag: pin.tag, visited: pin.visited),
          ],
        ),
      ),
    );
  }
}
