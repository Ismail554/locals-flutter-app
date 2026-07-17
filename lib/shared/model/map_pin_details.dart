import 'dart:ui';

class MapPinDetails {
  final String id;
  final String category;
  final String name;
  final String address;
  final int points;
  final Color? accentColor;
  final String? imageUrl;
  final double? latitude;
  final double? longitude;

  const MapPinDetails({
    required this.id,
    required this.category,
    required this.name,
    required this.address,
    required this.points,
    this.accentColor,
    this.imageUrl,
    this.latitude,
    this.longitude,
  });
}