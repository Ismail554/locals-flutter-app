import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:locals/features/map/map/view/widgets/map_marker_icon_cache.dart';
import 'package:locals/shared/components/profile_screen_header.dart';
import 'package:locals/shared/components/profile_segmented_control.dart';
import 'package:locals/shared/theme/app_colors.dart';
import '../controller/my_map_controller.dart';
import '../model/my_map_model.dart';
import '../repository/my_map_repository.dart';
import 'widgets/my_map_legend.dart';
import 'package:locals/core/localization/l10n_extensions.dart';

class MyMapScreen extends StatelessWidget {
  const MyMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MyMapController(MyMapRepositoryImpl()),
      child: const _MyMapView(),
    );
  }
}

class _MyMapView extends StatefulWidget {
  const _MyMapView();

  @override
  State<_MyMapView> createState() => _MyMapViewState();
}

class _MyMapViewState extends State<_MyMapView> {
  GoogleMapController? mapController;
  final Set<Marker> _markers = {};

  Future<void> _buildMarkers(MyMapModel state) async {
    _markers.clear();
    final iconCache = MapMarkerIconCache.instance;

    for (final pin in state.filteredPins) {
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
          onTap: () => context.read<MyMapController>().onPinTap(pin.id),
        ),
      );
    }

    if (mounted) setState(() {});
  }

  Future<void> _centerOnPins() async {
  if (mapController == null || _markers.isEmpty) return;

  if (_markers.length == 1) {
    final marker = _markers.first;
    await mapController!.animateCamera(
      CameraUpdate.newLatLngZoom(marker.position, 16.5),
    );
  } else {
    double minLat = 90.0;
    double maxLat = -90.0;
    double minLng = 180.0;
    double maxLng = -180.0;

    for (final marker in _markers) {
      final pos = marker.position;
      if (pos.latitude < minLat) minLat = pos.latitude;
      if (pos.latitude > maxLat) maxLat = pos.latitude;
      if (pos.longitude < minLng) minLng = pos.longitude;
      if (pos.longitude > maxLng) maxLng = pos.longitude;
    }

    final bounds = LatLngBounds(
      southwest: LatLng(minLat, minLng),
      northeast: LatLng(maxLat, maxLng),
    );

    await mapController!.animateCamera(
      CameraUpdate.newLatLngBounds(bounds, 80),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<MyMapController>();
    final state = controller.state;

    _buildMarkers(state);

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 0),
              child: ProfileScreenHeader(
                title: context.l10n.myMapTitle,
                onBack: () => context.pop(),
              ),
            ),
            SizedBox(height: 16.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: ProfileSegmentedControl(
                options: [
                  ProfileSegmentOption(
                    label: context.l10n.myMapFilterAll,
                    value: MyMapFilter.all.name,
                  ),
                  ProfileSegmentOption(
                    label: context.l10n.myMapFilterVisited(state.visitedCount),
                    value: MyMapFilter.visited.name,
                  ),
                  ProfileSegmentOption(
                    label: context.l10n.myMapFilterUnvisited(state.unvisitedCount),
                    value: MyMapFilter.unvisited.name,
                  ),
                ],
                selectedValue: state.selectedFilter.name,
                onChanged: (value) =>
                    controller.selectFilter(MyMapFilter.values.byName(value)),
              ),
            ),
            SizedBox(height: 12.h),
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Padding(
                padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 20.h),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.r),
                  child: GoogleMap(
                    mapType: MapType.satellite,
                    initialCameraPosition: const CameraPosition(
                      target: LatLng(41.3851, 2.1734),
                      zoom: 14,
                    ),
                    markers: _markers,
                    myLocationEnabled: true,
                    myLocationButtonEnabled: true,
                    zoomControlsEnabled: false,
                    compassEnabled: true,
                    onMapCreated: (GoogleMapController controller) {
                      mapController = controller;
                      _centerOnPins();
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}