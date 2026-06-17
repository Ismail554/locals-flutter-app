import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locals/shared/components/map/scrollable_map_canvas.dart';
import 'package:locals/shared/model/map_pin_info.dart';

class ViewProfileMapTab extends StatefulWidget {
  final List<MapPinInfo> pins;

  const ViewProfileMapTab({super.key, required this.pins});

  @override
  State<ViewProfileMapTab> createState() => _ViewProfileMapTabState();
}

class _ViewProfileMapTabState extends State<ViewProfileMapTab> {
  String? _selectedPinId;

  void _onPinTap(String pinId) {
    setState(() {
      _selectedPinId = _selectedPinId == pinId ? null : pinId;
    });
  }

  void _clearSelectedPin() {
    if (_selectedPinId == null) return;
    setState(() => _selectedPinId = null);
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.r),
      child: SizedBox(
        height: 280.h,
        width: double.infinity,
        child: ScrollableMapCanvas(
          pins: widget.pins,
          selectedPinId: _selectedPinId,
          onPinTap: _onPinTap,
          onBackgroundTap: _clearSelectedPin,
        ),
      ),
    );
  }
}
