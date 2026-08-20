import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationServiceException implements Exception {
  final String message;
  final bool shouldOpenSettings;

  const LocationServiceException(
    this.message, {
    this.shouldOpenSettings = false,
  });

  @override
  String toString() => message;
}

class LocationService {
  LocationService._();

  /// Gets the device location without hiding permission or service failures.
  static Future<LatLng> currentLocation() async {
    if (!await Geolocator.isLocationServiceEnabled()) {
      throw const LocationServiceException(
        'Location services are disabled. Please enable them and try again.',
      );
    }

    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever) {
      await Geolocator.openAppSettings();
      throw const LocationServiceException(
        'Location permission is permanently denied. Enable it in App Settings.',
        shouldOpenSettings: true,
      );
    }

    if (permission == LocationPermission.denied) {
      throw const LocationServiceException(
        'Location permission is required to show your position and directions.',
      );
    }

    try {
      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.bestForNavigation,
        ),
      ).timeout(const Duration(seconds: 10));
      return LatLng(position.latitude, position.longitude);
    } catch (error) {
      debugPrint('Location fetch failed: $error');
      throw const LocationServiceException(
        'Unable to get your location. Check GPS and try again.',
      );
    }
  }

  /// Real-time location stream (for live tracking)
  static Stream<LatLng> locationStream() {
    return Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.bestForNavigation,
        distanceFilter: 1,
      ),
    ).map((position) => LatLng(position.latitude, position.longitude));
  }

  /// Check if user is near destination (within 50 meters)
  static Future<bool> isNearDestination(LatLng destination) async {
    try {
      final current = await currentLocation();
      final distance = Geolocator.distanceBetween(
        current.latitude,
        current.longitude,
        destination.latitude,
        destination.longitude,
      );
      return distance < 50; // 50 meters radius
    } catch (e) {
      debugPrint("❌ Distance check failed: $e");
      return false;
    }
  }
}


