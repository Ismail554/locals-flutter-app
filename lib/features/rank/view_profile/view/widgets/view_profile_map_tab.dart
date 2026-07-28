import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:locals/features/map/map/controller/location_service.dart';
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
  LatLng? _currentUserLocation;
  String? _mapStyle;

  // ─── Current Location ─────────────────────────────────────────────────────

  Future<void> _loadMapStyle() async {
    final style = await rootBundle.loadString(
      'assets/map_styles/locals_map_style.json',
    );
    if (mounted) {
      setState(() => _mapStyle = style);
    }
  }

  Future<void> _updateCurrentLocation() async {
    try {
      final loc = await LocationService.currentLocation();
      if (!mounted) return;

      setState(() => _currentUserLocation = loc);
      _buildMarkers();
    } catch (e) {
      debugPrint("Could not get current location in profile map: $e");
    }
  }

  Future<void> _buildMarkers() async {
    _markers.clear();
    final iconCache = MapMarkerIconCache.instance;

    // Add user pins
    for (final pin in widget.pins) {
      final icon = await iconCache.iconFor(tag: pin.tag, visited: pin.visited);

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

    // Add Current Location Pin
    if (_currentUserLocation != null) {
      _markers.add(
        Marker(
          markerId: const MarkerId('current_location'),
          position: _currentUserLocation!,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          infoWindow: const InfoWindow(title: "You are here"),
          anchor: const Offset(0.5, 0.5),
        ),
      );
    }

    if (mounted) setState(() {});
  }

  Future<void> _centerOnPins() async {
    if (mapController == null) return;

    // If we have current location and no pins, center on user
    if (widget.pins.isEmpty && _currentUserLocation != null) {
      await mapController!.animateCamera(
        CameraUpdate.newLatLngZoom(_currentUserLocation!, 15.0),
      );
      return;
    }

    if (widget.pins.isEmpty) return;

    if (widget.pins.length == 1) {
      final pin = widget.pins.first;
      await mapController!.animateCamera(
        CameraUpdate.newLatLngZoom(LatLng(pin.lat, pin.lng), 16.5),
      );
    } else {
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
    _loadMapStyle();
    _buildMarkers();
    _updateCurrentLocation(); // ← Added
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.r),
      child: SizedBox(
        height: 280.h,
        width: double.infinity,
        child: GoogleMap(
          mapType: MapType.normal,
          style: _mapStyle,
          initialCameraPosition: const CameraPosition(
            target: LatLng(23.7809, 90.407992), // Dhaka default
            zoom: 13,
          ),
          markers: _markers,
          myLocationEnabled: true,
          myLocationButtonEnabled:
              false, // Hide default button (we have custom)
          zoomControlsEnabled: false,
          mapToolbarEnabled: false,
          compassEnabled: true,
          onMapCreated: (GoogleMapController controller) {
            mapController = controller;
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _centerOnPins();
            });
          },
        ),
      ),
    );
  }
}
