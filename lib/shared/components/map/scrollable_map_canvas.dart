import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locals/features/map/map/view/widgets/map_background.dart';
import 'package:locals/shared/components/map/map_pins_layer.dart';
import 'package:locals/shared/model/map_pin_info.dart';

class ScrollableMapCanvas extends StatefulWidget {
  final List<MapPinInfo> pins;
  final String? selectedPinId;
  final String? focusPinId;
  final ValueChanged<String> onPinTap;
  final VoidCallback? onBackgroundTap;
  final double contentScale;

  const ScrollableMapCanvas({
    super.key,
    required this.pins,
    required this.selectedPinId,
    this.focusPinId,
    required this.onPinTap,
    this.onBackgroundTap,
    this.contentScale = 1.6,
  });

  @override
  State<ScrollableMapCanvas> createState() => _ScrollableMapCanvasState();
}

class _ScrollableMapCanvasState extends State<ScrollableMapCanvas> {
  final TransformationController _transformController =
      TransformationController();
  bool _centered = false;

  @override
  void dispose() {
    _transformController.dispose();
    super.dispose();
  }

  void _scheduleCenter(double viewportWidth, double viewportHeight) {
    if (_centered || viewportWidth <= 0 || viewportHeight <= 0) return;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || _centered) return;

      final canvasWidth = viewportWidth * widget.contentScale;
      final canvasHeight = viewportHeight * widget.contentScale;

      double tx = -(canvasWidth - viewportWidth) / 2;
      double ty = -(canvasHeight - viewportHeight) / 2;

      final focusId = widget.focusPinId;
      if (focusId != null) {
        MapPinInfo? focusPin;
        for (final pin in widget.pins) {
          if (pin.id == focusId) {
            focusPin = pin;
            break;
          }
        }

        if (focusPin != null) {
          final pinX = focusPin.x * canvasWidth;
          final pinY = focusPin.y * canvasHeight;
          tx = viewportWidth / 2 - pinX;
          ty = viewportHeight / 2 - pinY;
        }
      }

      _transformController.value = Matrix4.translationValues(tx, ty, 0);
      _centered = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final viewportWidth = constraints.maxWidth;
        final viewportHeight = constraints.maxHeight;
        final canvasWidth = viewportWidth * widget.contentScale;
        final canvasHeight = viewportHeight * widget.contentScale;

        _scheduleCenter(viewportWidth, viewportHeight);

        return InteractiveViewer(
          transformationController: _transformController,
          boundaryMargin: EdgeInsets.all(32.w),
          minScale: 1.0,
          maxScale: 2.5,
          constrained: false,
          clipBehavior: Clip.hardEdge,
          child: SizedBox(
            width: canvasWidth,
            height: canvasHeight,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned.fill(
                  child: GestureDetector(
                    onTap: widget.onBackgroundTap,
                    behavior: HitTestBehavior.opaque,
                    child: const MapBackground(),
                  ),
                ),
                Positioned.fill(
                  child: MapPinsLayer(
                    pins: widget.pins,
                    selectedPinId: widget.selectedPinId,
                    onPinTap: widget.onPinTap,   // ← Passed correctly
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}