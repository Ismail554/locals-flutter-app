import 'package:flutter/material.dart';
import 'package:locals/features/map/map/model/map_model.dart';

enum ViewProfileTab { photos, map, achievements }

class ViewProfileAchievement {
  final String label;
  final IconData icon;
  final Color color;

  const ViewProfileAchievement({
    required this.label,
    required this.icon,
    required this.color,
  });
}

class ViewProfileMapPin {
  final double x;
  final double y;
  final MapPinType type;

  const ViewProfileMapPin({
    required this.x,
    required this.y,
    required this.type,
  });
}

class ViewProfileModel {
  final String name;
  final int level;
  final String location;
  final bool hasStory;
  final bool isFollowing;
  final int visits;
  final int followers;
  final int cities;
  final ViewProfileTab selectedTab;
  final List<Color> photoColors;
  final List<ViewProfileAchievement> achievements;
  final List<ViewProfileMapPin> mapPins;

  const ViewProfileModel({
    this.name = 'Marta',
    this.level = 18,
    this.location = 'Barcelona',
    this.hasStory = true,
    this.isFollowing = false,
    this.visits = 63,
    this.followers = 456,
    this.cities = 3,
    this.selectedTab = ViewProfileTab.photos,
    this.photoColors = const [
      Color(0xFFD4A574),
      Color(0xFF7EB8DA),
      Color(0xFFE8A0A0),
      Color(0xFF9BB5CE),
      Color(0xFFC4B5A0),
      Color(0xFF8FA89A),
      Color(0xFFB8C8D8),
      Color(0xFFD8C8B8),
      Color(0xFFA8B8C8),
    ],
    this.achievements = const [
      ViewProfileAchievement(
        label: 'First Local',
        icon: Icons.eco_outlined,
        color: Color(0xFF4CD964),
      ),
      ViewProfileAchievement(
        label: '10 Visits',
        icon: Icons.location_on_outlined,
        color: Color(0xFFEA4D70),
      ),
      ViewProfileAchievement(
        label: 'Café Connoisseur',
        icon: Icons.coffee_outlined,
        color: Color(0xFF8B6914),
      ),
      ViewProfileAchievement(
        label: 'Night Owl',
        icon: Icons.nightlight_outlined,
        color: Color(0xFFFFB800),
      ),
    ],
    this.mapPins = const [
      ViewProfileMapPin(x: 0.22, y: 0.18, type: MapPinType.red),
      ViewProfileMapPin(x: 0.72, y: 0.14, type: MapPinType.greyStar),
      ViewProfileMapPin(x: 0.48, y: 0.28, type: MapPinType.greyDot),
      ViewProfileMapPin(x: 0.35, y: 0.42, type: MapPinType.darkStar),
      ViewProfileMapPin(x: 0.62, y: 0.38, type: MapPinType.red),
      ViewProfileMapPin(x: 0.18, y: 0.55, type: MapPinType.greyStar),
    ],
  });

  ViewProfileModel copyWith({
    bool? isFollowing,
    ViewProfileTab? selectedTab,
  }) {
    return ViewProfileModel(
      name: name,
      level: level,
      location: location,
      hasStory: hasStory,
      isFollowing: isFollowing ?? this.isFollowing,
      visits: visits,
      followers: followers,
      cities: cities,
      selectedTab: selectedTab ?? this.selectedTab,
      photoColors: photoColors,
      achievements: achievements,
      mapPins: mapPins,
    );
  }
}
