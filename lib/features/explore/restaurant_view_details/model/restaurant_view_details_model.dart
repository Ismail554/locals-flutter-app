import 'package:flutter/material.dart';
import 'package:locals/shared/model/check_in_photo_model.dart';
import 'package:locals/features/explore/points/model/points_args.dart';
import 'package:locals/features/map/map/model/map_mission_args.dart';

class RestaurantPhoto {
  final Color color;
  final String timeAgo;
  final String caption;
  final int likes;
  final String? imageUrl;

  const RestaurantPhoto({
    required this.color,
    required this.timeAgo,
    required this.caption,
    required this.likes,
    this.imageUrl,
  });

  CheckInPhoto toCheckInPhoto(String locationName) {
    return CheckInPhoto(
      previewColor: color,
      locationName: locationName,
      timeAgo: timeAgo,
      caption: caption,
      likes: likes,
      imageUrl: imageUrl,
    );
  }

  factory RestaurantPhoto.fromApi(Map<String, dynamic> json) {
    return RestaurantPhoto(
      color: const Color(0xFFD4C4B0),
      timeAgo: json['created_at_relative'] as String? ?? '',
      caption: json['caption'] as String? ?? '',
      likes: json['likes_count'] as int? ?? 0,
      imageUrl: json['full_image_url'] as String?,
    );
  }
}

class RestaurantVisitor {
  final String name;
  final String? avatarUrl;

  const RestaurantVisitor({required this.name, this.avatarUrl});

  factory RestaurantVisitor.fromApi(Map<String, dynamic> json) {
    return RestaurantVisitor(
      name: json['full_name'] as String? ?? '',
      avatarUrl: json['avatar'] as String?,
    );
  }
}

class RestaurantViewDetailsModel {
  final String id;
  final String category;
  final String name;
  final bool hasLocalsSeal;
  final Color heroColor;
  final String? heroImageUrl;
  final String shortDescription;
  final String fullDescription;
  final String address;
  final String hours;
  final String instagramHandle;
  final int points;
  final List<RestaurantPhoto> photos;
  final int visitorCount;
  final List<Color> visitorAvatarColors;
  final List<RestaurantVisitor> visitors;
  final bool hasVisited;
  final bool isSaved;
  final bool businessOfTheMonth;
  final double latitude;
  final double longitude;

  const RestaurantViewDetailsModel({
    required this.id,
    required this.category,
    required this.name,
    required this.hasLocalsSeal,
    required this.heroColor,
    this.heroImageUrl,
    required this.shortDescription,
    required this.fullDescription,
    required this.address,
    required this.hours,
    required this.instagramHandle,
    required this.latitude,
    required this.longitude,
    required this.points,
    required this.photos,
    required this.visitorCount,
    required this.visitorAvatarColors,
    this.visitors = const [],
    this.hasVisited = false,
    this.isSaved = false,
    this.businessOfTheMonth = false,
  });

  String get shareUrl => 'https://clubby-andy-irksomely.ngrok-free.dev/l/$id';

  String get mapPinId => switch (id) {
    'sagrada_familia' => 'sagrada',
    _ => id,
  };

  PointsArgs toPointsArgs() {
    return PointsArgs(
      locationId: id,
      locationName: name,
      points: points,
      locationCategory: category,
      locationAddress: address,
      locationColor: heroColor,
    );
  }

  MapActiveLocation toMapLocation() {
    return MapActiveLocation(
      locationId: id,
      category: category,
      seal: hasLocalsSeal ? "locals' seal" : "Local spot",
      name: name,
      address: address,
      points: points,
      imageColor: heroColor,
      latitude: latitude,
      longitude: longitude,
    );
  }

  RestaurantViewDetailsModel copyWith({bool? hasVisited, bool? isSaved}) {
    return RestaurantViewDetailsModel(
      id: id,
      category: category,
      name: name,
      hasLocalsSeal: hasLocalsSeal,
      heroColor: heroColor,
      heroImageUrl: heroImageUrl,
      shortDescription: shortDescription,
      fullDescription: fullDescription,
      address: address,
      hours: hours,
      instagramHandle: instagramHandle,
      points: points,
      photos: photos,
      visitorCount: visitorCount,
      visitorAvatarColors: visitorAvatarColors,
      latitude: latitude,
      longitude: longitude,
      visitors: visitors,
      hasVisited: hasVisited ?? this.hasVisited,
      isSaved: isSaved ?? this.isSaved,
      businessOfTheMonth: businessOfTheMonth,
    );
  }

  /// Maps a `GET /places/:id/` response to the detail model.
  factory RestaurantViewDetailsModel.fromApi(Map<String, dynamic> json) {
    final categoryJson = json['category'] as Map<String, dynamic>?;
    final visitStatus = json['user_visit_status'] as String? ?? 'UNVISITED';

    final visitorsRaw = json['visitors'] as List? ?? [];
    final visitors = visitorsRaw
        .map((v) => RestaurantVisitor.fromApi(v as Map<String, dynamic>))
        .toList();

    final photosRaw = json['photos'] as List? ?? [];
    final photos = photosRaw
        .map((p) => RestaurantPhoto.fromApi(p as Map<String, dynamic>))
        .toList();

    // Build avatar color list from visitor data (or fallback palette)
    final avatarColors = visitors.isNotEmpty
        ? visitors.take(6).map((_) => const Color(0xFFD4A574)).toList()
        : <Color>[];

    return RestaurantViewDetailsModel(
      id: json['id'].toString(),
      category: (categoryJson?['name'] as String? ?? '').toUpperCase(),
      name: json['name'] as String? ?? '',
      hasLocalsSeal: json['has_locals_seal'] as bool? ?? false,
      heroColor: const Color(0xFFD4C4B0),
      heroImageUrl: json['cover_photo'] as String?,
      shortDescription: json['description'] as String? ?? '',
      fullDescription: json['description'] as String? ?? '',
      address: json['address'] as String? ?? '',
      hours: json['opening_hours'] as String? ?? '',
      instagramHandle:
          json['instagram_handle'] != null &&
              (json['instagram_handle'] as String).isNotEmpty
          ? '@${json['instagram_handle']}'
          : '',
      points: json['base_points'] as int? ?? 0,
      photos: photos,
      visitorCount: json['total_visitors_count'] as int? ?? 0,

      latitude: double.tryParse(json['latitude']?.toString() ?? '') ?? 0.0,
      longitude: double.tryParse(json['longitude']?.toString() ?? '') ?? 0.0,

      visitorAvatarColors: avatarColors,
      visitors: visitors,
      hasVisited: visitStatus != 'UNVISITED',
      isSaved: json['is_saved'] as bool? ?? false,
      businessOfTheMonth: json['is_business_of_the_month'] as bool? ?? false,
    );
  }
}
