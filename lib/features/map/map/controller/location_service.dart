import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationService {
  LocationService._();

  static Future<LatLng> currentLocation() async {
    // FORCE BARCELONA FOR TESTING - Remove this after testing on real device
    const LatLng barcelona = LatLng(41.3851, 2.1734);
    debugPrint("🧪 FORCED Barcelona Location for testing");
    return barcelona;
  }

  // static Future<LatLng> currentLocation() async {
  //   try {
  //     bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //     if (!serviceEnabled) {
  //       return const LatLng(41.3851, 2.1734);
  //     }

  //     LocationPermission permission = await Geolocator.checkPermission();
  //     if (permission == LocationPermission.denied) {
  //       permission = await Geolocator.requestPermission();
  //     }

  //     if (permission == LocationPermission.denied ||
  //         permission == LocationPermission.deniedForever) {
  //       return const LatLng(41.3851, 2.1734);
  //     }

  //     final position = await Geolocator.getCurrentPosition(
  //       desiredAccuracy: LocationAccuracy.bestForNavigation,
  //       timeLimit: const Duration(seconds: 10),
  //     );

  //     debugPrint(
  //       "✅ Real Location: ${position.latitude}, ${position.longitude}",
  //     );
  //     return LatLng(position.latitude, position.longitude);
  //   } catch (e) {
  //     debugPrint("❌ Location failed, using Barcelona: $e");
  //     return const LatLng(41.3851, 2.1734);
  //   }
  // }
}
