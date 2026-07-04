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
      "&key=$_apiKey",
    );

    debugPrint("========== DIRECTIONS REQUEST ==========");
    debugPrint("URL: $url");
    debugPrint("Origin: ${origin.latitude}, ${origin.longitude}");
    debugPrint("Destination: ${destination.latitude}, ${destination.longitude}");

    try {
      final response = await http.get(url);

      debugPrint("HTTP Status: ${response.statusCode}");
      debugPrint("Response Body:");
      debugPrint(response.body);

      if (response.statusCode != 200) {
        throw Exception(
          "Directions API failed with status ${response.statusCode}",
        );
      }

      final json = jsonDecode(response.body);

      debugPrint("Directions Status: ${json["status"]}");

      if (json["status"] != "OK") {
        debugPrint("Directions Error: ${json["error_message"]}");
        return [];
      }

      final routes = json["routes"] as List;

      debugPrint("Routes Found: ${routes.length}");

      if (routes.isEmpty) {
        debugPrint("No routes returned.");
        return [];
      }

      final encoded =
          routes.first["overview_polyline"]["points"] as String;

      debugPrint("Encoded Polyline Length: ${encoded.length}");

      final decoded = PolylinePoints.decodePolyline(encoded);

      debugPrint("Decoded Points: ${decoded.length}");

      final points = decoded
          .map(
            (e) => LatLng(
              e.latitude,
              e.longitude,
            ),
          )
          .toList();

      debugPrint("Returning ${points.length} LatLng points.");
      debugPrint("========================================");

      return points;
    } catch (e, stackTrace) {
      debugPrint("RouteService Error: $e");
      debugPrintStack(stackTrace: stackTrace);
      return [];
    }
  }

  Future<double?> getDistance({
    required LatLng origin,
    required LatLng destination,
  }) async {
    final url = Uri.parse(
      "https://maps.googleapis.com/maps/api/directions/json"
      "?origin=${origin.latitude},${origin.longitude}"
      "&destination=${destination.latitude},${destination.longitude}"
      "&mode=driving"
      "&key=$_apiKey",
    );

    try {
      final response = await http.get(url);

      if (response.statusCode != 200) return null;

      final json = jsonDecode(response.body);

      if (json["status"] != "OK") {
        debugPrint("Distance API Status: ${json["status"]}");
        return null;
      }

      return (json["routes"][0]["legs"][0]["distance"]["value"] as num)
              .toDouble() /
          1000;
    } catch (e) {
      debugPrint("Distance Error: $e");
      return null;
    }
  }

  Future<String?> getDuration({
    required LatLng origin,
    required LatLng destination,
  }) async {
    final url = Uri.parse(
      "https://maps.googleapis.com/maps/api/directions/json"
      "?origin=${origin.latitude},${origin.longitude}"
      "&destination=${destination.latitude},${destination.longitude}"
      "&mode=driving"
      "&key=$_apiKey",
    );

    try {
      final response = await http.get(url);

      if (response.statusCode != 200) return null;

      final json = jsonDecode(response.body);

      if (json["status"] != "OK") {
        debugPrint("Duration API Status: ${json["status"]}");
        return null;
      }

      return json["routes"][0]["legs"][0]["duration"]["text"];
    } catch (e) {
      debugPrint("Duration Error: $e");
      return null;
    }
  }
}