import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:locals/features/map/map/view/widgets/map_marker_icon_cache.dart';
import 'package:locals/shared/model/map_pin_info.dart';

class ViewProfileMapTab extends StatefulWidget {
  final List<MapPinInfo> pins;

  const ViewProfileMapTab({super.key, required this.pins});

  @override
  State<ViewProfileMapTab> createState() => _ViewProfileMapTabState();
}

class _ViewProfileMapTabState extends State<ViewProfileMapTab> {
  GoogleMapController? mapController;
  String? selectedPinId;

  final Set<Marker> _markers = {};

  Future<void> _buildMarkers() async {
    _markers.clear();
    final iconCache = MapMarkerIconCache.instance;

    for (final pin in widget.pins) {
      final icon = await iconCache.iconFor(
        tag: pin.tag,
        visited: pin.visited,
      );

      _markers.add(
        Marker(
          markerId: MarkerId(pin.id),
          position: LatLng(pin.lat, pin.lng),
          icon: icon,
          infoWindow: InfoWindow(title: pin.name),
          onTap: () => setState(() => selectedPinId = pin.id),
        ),
      );
    }

    if (mounted) setState(() {});
  }

  Future<void> _centerOnPins() async {
    if (mapController == null || widget.pins.isEmpty) return;

    if (widget.pins.length == 1) {
      // Single pin → zoom in
      final pin = widget.pins.first;
      await mapController!.animateCamera(
        CameraUpdate.newLatLngZoom(
          LatLng(pin.lat, pin.lng),
          16.5,
        ),
      );
    } else {
      // Multiple pins → fit bounds
      double minLat = widget.pins.first.lat;
      double maxLat = widget.pins.first.lat;
      double minLng = widget.pins.first.lng;
      double maxLng = widget.pins.first.lng;

      for (final pin in widget.pins) {
        if (pin.lat < minLat) minLat = pin.lat;
        if (pin.lat > maxLat) maxLat = pin.lat;
        if (pin.lng < minLng) minLng = pin.lng;
        if (pin.lng > maxLng) maxLng = pin.lng;
      }

      final bounds = LatLngBounds(
        southwest: LatLng(minLat, minLng),
        northeast: LatLng(maxLat, maxLng),
      );

      await mapController!.animateCamera(
        CameraUpdate.newLatLngBounds(bounds, 60),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _buildMarkers();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.r),
      child: SizedBox(
        height: 280.h,
        width: double.infinity,
        child: GoogleMap(
          mapType: MapType.satellite,
          initialCameraPosition: const CameraPosition(
            target: LatLng(41.3851, 2.1734),
            zoom: 13,
          ),
          markers: _markers,
          myLocationEnabled: false,
          zoomControlsEnabled: false,
          mapToolbarEnabled: false,
          compassEnabled: true,
          onMapCreated: (GoogleMapController controller) {
            mapController = controller;
            // Center on pins after map is ready
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _centerOnPins();
            });
          },
        ),
      ),
    );
  }
}