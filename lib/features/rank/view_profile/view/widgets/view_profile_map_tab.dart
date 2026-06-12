import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locals/features/map/map/view/widgets/map_background.dart';
import 'package:locals/features/map/map/view/widgets/map_pin_marker.dart';
import '../../model/view_profile_model.dart';

class ViewProfileMapTab extends StatelessWidget {
  final List<ViewProfileMapPin> pins;

  const ViewProfileMapTab({super.key, required this.pins});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.r),
      child: SizedBox(
        height: 280.h,
        width: double.infinity,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final mapWidth = constraints.maxWidth;
            final mapHeight = constraints.maxHeight;

            return Stack(
              fit: StackFit.expand,
              children: [
                const MapBackground(),
                ...pins.map((pin) {
                  return Positioned(
                    left: pin.x * mapWidth - 18.w,
                    top: pin.y * mapHeight - 24.h,
                    child: MapPinMarker(type: pin.type),
                  );
                }),
              ],
            );
          },
        ),
      ),
    );
  }
}
