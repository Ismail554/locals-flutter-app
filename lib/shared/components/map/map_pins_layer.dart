import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locals/shared/components/map/map_interactive_pin.dart';
import 'package:locals/shared/model/map_pin_info.dart';

class MapPinsLayer extends StatelessWidget {
  final List<MapPinInfo> pins;
  final String? selectedPinId;
  final ValueChanged<String> onPinTap;

  const MapPinsLayer({
    super.key,
    required this.pins,
    required this.selectedPinId,
    required this.onPinTap,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final mapWidth = constraints.maxWidth;
        final mapHeight = constraints.maxHeight;

        return Stack(
          clipBehavior: Clip.none,
          children: [
            for (final pin in pins)
              Positioned(
                left: pin.x * mapWidth - MapInteractivePin.pinWidth.w / 2,
                top: pin.y * mapHeight - MapInteractivePin.pinHeight.h,
                child: MapInteractivePin(
                  pin: pin,
                  isSelected: selectedPinId == pin.id,
                  onTap: () => onPinTap(pin.id),
                ),
              ),
          ],
        );
      },
    );
  }
}
