import 'dart:ui' as ui;

import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:locals/shared/model/map_pin_tag.dart';

class MapMarkerIconCache {
  MapMarkerIconCache._();

  static final MapMarkerIconCache instance = MapMarkerIconCache._();

  final Map<String, BitmapDescriptor> _cache = {};

  Future<BitmapDescriptor> iconFor({
    required MapPinTag tag,
    required bool visited,
  }) async {
    final key = '${tag.name}_$visited';
    final cached = _cache[key];
    if (cached != null) return cached;

    final assetPath = tag.assetPath(visited: visited);
    final icon = await _loadFromAsset(assetPath);
    _cache[key] = icon;
    return icon;
  }
  Future<void> preloadAll() async {
    for (final tag in MapPinTag.values) {
      await iconFor(tag: tag, visited: true);
      await iconFor(tag: tag, visited: false);
    }
  }

  Future<BitmapDescriptor> _loadFromAsset(
    String assetPath, {
    int targetWidth = 96,
  }) async {
    final data = await rootBundle.load(assetPath);
    final codec = await ui.instantiateImageCodec(
      data.buffer.asUint8List(),
      targetWidth: targetWidth,
    );
    final frame = await codec.getNextFrame();
    final bytes = await frame.image.toByteData(format: ui.ImageByteFormat.png);

    if (bytes == null) {
      return BitmapDescriptor.defaultMarker;
    }

    return BitmapDescriptor.bytes(bytes.buffer.asUint8List());
  }
}