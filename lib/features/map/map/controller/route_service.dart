import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:locals/core/config/app_config.dart';

class RouteService {
  RouteService._();

  static final RouteService instance = RouteService._();

  static String get _apiKey => AppConfig.googleMapKey;

  Future<List<LatLng>> getRoute({
    required LatLng origin,
    required LatLng destination,
  }) async {
    final url = Uri.parse(
      "https://maps.googleapis.com/maps/api/directions/json"
      "?origin=${origin.latitude},${origin.longitude}"
      "&destination=${destination.latitude},${destination.longitude}"
      "&mode=driving"
      "&alternatives=true"
      "&language=en"
      "&key=$_apiKey",
    );

    if (kDebugMode) {
      debugPrint("========== DIRECTIONS REQUEST ==========");
      debugPrint("URL: $url");
      debugPrint("Origin: ${origin.latitude}, ${origin.longitude}");
      debugPrint(
        "Destination: ${destination.latitude}, ${destination.longitude}",
      );
    }

    try {
      final response = await http.get(url).timeout(const Duration(seconds: 15));

      if (kDebugMode) {
        debugPrint("HTTP Status: ${response.statusCode}");
      }

      if (response.statusCode != 200) {
        debugPrint("Directions API HTTP Error: ${response.statusCode}");
        return [];
      }

      final json = jsonDecode(response.body);

      if (kDebugMode) {
        debugPrint("Directions Status: ${json["status"]}");
      }

      if (json["status"] != "OK") {
        final errorMsg = json["error_message"] ?? 'Unknown error';
        if (kDebugMode) debugPrint("Directions Error: $errorMsg");
        return [];
      }

      final routes = json["routes"] as List<dynamic>;

      if (routes.isEmpty) {
        if (kDebugMode) debugPrint("No routes returned.");
        return [];
      }

      final bestRoute = _selectBestRoute(routes);
      if (bestRoute == null) {
        if (kDebugMode) debugPrint("No valid route found.");
        return [];
      }

      final points = <LatLng>[];
      final legs = bestRoute["legs"] as List<dynamic>? ?? const [];

      for (final leg in legs) {
        final steps =
            (leg as Map<String, dynamic>)["steps"] as List<dynamic>? ??
            const [];
        for (final step in steps) {
          final stepMap = step as Map<String, dynamic>;
          final encoded = stepMap["polyline"]?["points"] as String?;
          if (encoded == null || encoded.isEmpty) continue;

          final decoded = PolylinePoints.decodePolyline(encoded);
          points.addAll(
            decoded.map((e) => LatLng(e.latitude, e.longitude)).toList(),
          );
        }
      }

      if (points.isEmpty) {
        final encoded = bestRoute["overview_polyline"]?["points"] as String?;
        if (encoded == null || encoded.isEmpty) {
          return [];
        }

        final decoded = PolylinePoints.decodePolyline(encoded);
        return decoded.map((e) => LatLng(e.latitude, e.longitude)).toList();
      }

      if (kDebugMode) {
        debugPrint("Decoded Points: ${points.length}");
        debugPrint("========================================");
      }

      return points;
    } catch (e, stackTrace) {
      if (kDebugMode) {
        debugPrint("RouteService Error: $e");
        debugPrintStack(stackTrace: stackTrace);
      }
      return [];
    }
  }

  Map<String, dynamic>? _selectBestRoute(List<dynamic> routes) {
    Map<String, dynamic>? bestRoute;
    double? bestDistance;

    for (final route in routes) {
      if (route is! Map<String, dynamic>) continue;

      final legs = route["legs"] as List<dynamic>? ?? const [];
      if (legs.isEmpty) continue;

      final firstLeg = legs.first as Map<String, dynamic>;
      final distanceValue = firstLeg["distance"]?["value"] as num?;
      final distance = distanceValue?.toDouble();

      if (distance == null) continue;

      if (bestRoute == null || distance < (bestDistance ?? double.infinity)) {
        bestRoute = route;
        bestDistance = distance;
      }
    }

    return bestRoute;
  }

  // Keep your distance and duration methods
  Future<double?> getDistance({
    required LatLng origin,
    required LatLng destination,
  }) async {
    try {
      final url = Uri.parse(
        "https://maps.googleapis.com/maps/api/directions/json"
        "?origin=${origin.latitude},${origin.longitude}"
        "&destination=${destination.latitude},${destination.longitude}"
        "&mode=driving"
        "&key=$_apiKey",
      );

      final response = await http.get(url).timeout(const Duration(seconds: 10));
      if (response.statusCode != 200) return null;

      final json = jsonDecode(response.body);
      if (json["status"] != "OK") return null;

      return (json["routes"][0]["legs"][0]["distance"]["value"] as num)
              .toDouble() /
          1000;
    } catch (e) {
      if (kDebugMode) debugPrint("Distance Error: $e");
      return null;
    }
  }

  Future<String?> getDuration({
    required LatLng origin,
    required LatLng destination,
  }) async {
    try {
      final url = Uri.parse(
        "https://maps.googleapis.com/maps/api/directions/json"
        "?origin=${origin.latitude},${origin.longitude}"
        "&destination=${destination.latitude},${destination.longitude}"
        "&mode=driving"
        "&key=$_apiKey",
      );

      final response = await http.get(url).timeout(const Duration(seconds: 10));
      if (response.statusCode != 200) return null;

      final json = jsonDecode(response.body);
      if (json["status"] != "OK") return null;

      return json["routes"][0]["legs"][0]["duration"]["text"] as String?;
    } catch (e) {
      if (kDebugMode) debugPrint("Duration Error: $e");
      return null;
    }
  }
}
