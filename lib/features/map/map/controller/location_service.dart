import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationService {
  LocationService._();

  /// Get single current location (Real device location with fallback)
  static Future<LatLng> currentLocation() async {
    try {
      // Check if location service is enabled
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        debugPrint("❌ Location service disabled → Using fallback");
        return const LatLng(23.7809, 90.407992);
      }

      // Check permission
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      // Handle denied or permanently denied
      if (permission == LocationPermission.denied || 
          permission == LocationPermission.deniedForever) {
        debugPrint("❌ Location permission denied → Using fallback");
        return const LatLng(23.7809, 90.407992);
      }

      // Get current position
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation,
        timeLimit: const Duration(seconds: 10),
      );

      debugPrint("✅ Real Location: ${position.latitude}, ${position.longitude}");
      
      return LatLng(position.latitude, position.longitude);
    } catch (e) {
      debugPrint("❌ Location failed → Using fallback: $e");
      return const LatLng(23.7809, 90.407992); 
    }
  }

  /// Real-time location stream (for live tracking)
  static Stream<LatLng> locationStream() {
    return Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.bestForNavigation,
        distanceFilter: 1, // Update every ~8 meters
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










// import 'package:flutter/foundation.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// class LocationService {
//   LocationService._();


//     static Future<LatLng> currentLocation() async {
//     // FORCE BARCELONA FOR TESTING - Remove this after testing on real device
//     const LatLng Dhaka = LatLng(23.7809, 90.407992);
//     debugPrint("🧪 FORCED Dhaka Location for testing");
//     return Dhaka;
//   }


//   /// Get single current location (with fallback)
//   // static Future<LatLng> currentLocation() async {
//   //   try {
//   //     bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
//   //     if (!serviceEnabled) {
//   //       debugPrint("❌ Location service disabled → Barcelona fallback");
//   //       return const LatLng(41.3851, 2.1734);
//   //     }

//   //     LocationPermission permission = await Geolocator.checkPermission();
//   //     if (permission == LocationPermission.denied) {
//   //       permission = await Geolocator.requestPermission();
//   //     }

//   //     if (permission == LocationPermission.denied || 
//   //         permission == LocationPermission.deniedForever) {
//   //       debugPrint("❌ Permission denied → Barcelona fallback");
//   //       return const LatLng(41.3851, 2.1734);
//   //     }

//   //     final position = await Geolocator.getCurrentPosition(
//   //       desiredAccuracy: LocationAccuracy.bestForNavigation,
//   //       timeLimit: const Duration(seconds: 10),
//   //     );

//   //     debugPrint("✅ Real Location: ${position.latitude}, ${position.longitude}");
//   //     return LatLng(position.latitude, position.longitude);
//   //   } catch (e) {
//   //     debugPrint("❌ Location failed → Barcelona fallback: $e");
//   //     return const LatLng(41.3851, 2.1734);
//   //   }
//   // }

//   /// Real-time location stream (for live tracking)
//   static Stream<LatLng> locationStream() {
//     return Geolocator.getPositionStream(
//       locationSettings: const LocationSettings(
//         accuracy: LocationAccuracy.bestForNavigation,
//         distanceFilter: 8, // Update every ~8 meters
//       ),
//     ).map((position) => LatLng(position.latitude, position.longitude));
//   }

//   /// Check if user is near destination (within 50 meters)
//   static Future<bool> isNearDestination(LatLng destination) async {
//     try {
//       final current = await currentLocation();
//       final distance = Geolocator.distanceBetween(
//         current.latitude,
//         current.longitude,
//         destination.latitude,
//         destination.longitude,
//       );
//       return distance < 50; // 50 meters radius
//     } catch (e) {
//       return false;
//     }
//   }
// }



