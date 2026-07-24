import 'package:flutter/material.dart';
import 'package:locals/features/map/map/model/map_mission_args.dart';
import 'package:locals/features/explore/restaurant_view_details/model/qr_checkin_result.dart';

class PointsArgs {
  final String locationName;
  final int points;

  // These only come from a fresh QR check-in response. When PointsArgs is
  // built any other way (e.g. RestaurantViewDetailsModel.toPointsArgs() for
  // an already-visited place), we genuinely don't have this data — so it's
  // nullable rather than filled with fake numbers.
  final String? cityName;
  final double? cityProgress; // 0.0 - 1.0
  final int? level;
  final int? totalPoints;
  final int? cityPercent; // 0 - 100

  final int? completedCount;
  final int? totalCount;
  final String? locationCategory;
  final String? locationAddress;
  final Color? locationColor;
  final String? locationId;
  final String? eventId;
  final bool missionCompleted;
  final List<String> unlockedAchievements;
  final double? latitude;
  final double? longitude;

  const PointsArgs({
    required this.locationName,
    required this.points,
    this.cityName,
    this.cityProgress,
    this.level,
    this.totalPoints,
    this.cityPercent,
    this.locationId,
    this.completedCount,
    this.totalCount,
    this.locationCategory,
    this.locationAddress,
    this.locationColor,
    this.eventId,
    this.missionCompleted = false,
    this.unlockedAchievements = const [],
    this.latitude,
    this.longitude,
  });

  /// Builds PointsArgs straight from the `/gamification/qr-checkin/`
  /// response. Unlike the base constructor, the gamification fields here
  /// ARE required — this factory should only be called right after a real
  /// check-in, where the API actually returned them.
  factory PointsArgs.fromCheckIn({
    required QRCheckInResult result,
    required String locationId,
    required String cityName,
    String? locationName,
    String? locationCategory,
    String? locationAddress,
    Color? locationColor,
    double? latitude,
    double? longitude,
    int? completedCount,
    int? totalCount,
    String? eventId,
  }) {
    final cityCompletion = result.cityCompletionPercentage ?? 0.0;

    return PointsArgs(
      locationName: result.placeName ?? locationName ?? '',
      points: result.pointsEarned ?? 0,
      cityName: cityName,
      cityProgress: cityCompletion / 100,
      level: result.newLevel ?? 0,
      totalPoints: result.newTotalPoints ?? 0,
      cityPercent: cityCompletion.round(),
      locationId: locationId,
      locationCategory: locationCategory,
      locationAddress: locationAddress,
      locationColor: locationColor,
      eventId: eventId,
      missionCompleted: result.missionCompleted,
      unlockedAchievements: result.unlockedAchievements,
      latitude: latitude,
      longitude: longitude,
      completedCount: completedCount,
      totalCount: totalCount,
    );
  }

  MapMissionArgs toMapMissionArgs() {
    return MapMissionArgs(
      city: cityName ?? '',
      completedCount: completedCount ?? 0,
      totalCount: totalCount ?? 0,
      eventId: eventId,
      activeLocation: MapActiveLocation(
        locationId: locationId,
        category: locationCategory ?? '',
        seal: "locals' seal",
        name: locationName,
        address: locationAddress ?? '',
        points: points,
        imageColor: locationColor ?? const Color(0xFFD4C4B0),
        latitude: latitude ?? 0,
        longitude: longitude ?? 0,
      ),
    );
  }
}