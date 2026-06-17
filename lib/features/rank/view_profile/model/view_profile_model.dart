import 'package:flutter/material.dart';
import 'package:locals/shared/model/map_pin_info.dart';
import 'package:locals/shared/model/map_pin_tag.dart';
import 'package:locals/shared/model/check_in_photo_model.dart';

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

class ViewProfileModel {
  final String name;
  final int level;
  final String location;
  final bool hasStory;
  final bool isFollowing;
  final String? storyUserId;
  final int visits;
  final int followers;
  final int cities;
  final ViewProfileTab selectedTab;
  final List<CheckInPhoto> photos;
  final List<ViewProfileAchievement> achievements;
  final List<MapPinInfo> mapPins;

  const ViewProfileModel({
    this.name = 'Marta',
    this.level = 18,
    this.location = 'Barcelona',
    this.hasStory = true,
    this.storyUserId = 'marta',
    this.isFollowing = false,
    this.visits = 63,
    this.followers = 456,
    this.cities = 3,
    this.selectedTab = ViewProfileTab.photos,
    this.photos = const [
      CheckInPhoto(
        previewColor: Color(0xFFD4A574),
        locationName: 'Cafe',
        timeAgo: '2d ago',
        caption: 'Best cortado in the Born.',
        likes: 24,
      ),
      CheckInPhoto(
        previewColor: Color(0xFF7EB8DA),
        locationName: 'Bakery',
        timeAgo: '4d ago',
        caption: 'Morning pastries run.',
        likes: 18,
      ),
      CheckInPhoto(
        previewColor: Color(0xFFE8A0A0),
        locationName: 'Restaurant',
        timeAgo: '1w ago',
        caption: 'Dinner with friends.',
        likes: 31,
      ),
      CheckInPhoto(
        previewColor: Color(0xFF9BB5CE),
        locationName: 'Park',
        timeAgo: '1w ago',
        caption: 'Sunset walk.',
        likes: 12,
      ),
      CheckInPhoto(
        previewColor: Color(0xFFC4B5A0),
        locationName: 'Market',
        timeAgo: '2w ago',
        caption: 'Fresh produce haul.',
        likes: 9,
      ),
      CheckInPhoto(
        previewColor: Color(0xFF8FA89A),
        locationName: 'Bar',
        timeAgo: '3w ago',
        caption: 'Friday night spot.',
        likes: 42,
      ),
      CheckInPhoto(
        previewColor: Color(0xFFB8C8D8),
        locationName: 'Cafe',
        timeAgo: '3w ago',
        caption: 'Quiet corner table.',
        likes: 15,
      ),
      CheckInPhoto(
        previewColor: Color(0xFFD8C8B8),
        locationName: 'Bakery',
        timeAgo: '1mo ago',
        caption: 'Weekend brunch.',
        likes: 27,
      ),
      CheckInPhoto(
        previewColor: Color(0xFFA8B8C8),
        locationName: 'Restaurant',
        timeAgo: '1mo ago',
        caption: 'New tasting menu.',
        likes: 36,
      ),
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
      MapPinInfo(
        id: 'cafe_del_born',
        name: 'Café del Born',
        level: 12,
        x: 0.22,
        y: 0.18,
        tag: MapPinTag.business,
        visited: true,
      ),
      MapPinInfo(
        id: 'parc_guell',
        name: 'Parc Güell',
        level: 8,
        x: 0.72,
        y: 0.14,
        tag: MapPinTag.pointOfInterest,
        visited: false,
      ),
      MapPinInfo(
        id: 'forn_baluard',
        name: 'Forn Baluard',
        level: 6,
        x: 0.48,
        y: 0.28,
        tag: MapPinTag.business,
        visited: false,
      ),
      MapPinInfo(
        id: 'casa_batllo',
        name: 'Casa Batlló',
        level: 16,
        x: 0.35,
        y: 0.42,
        tag: MapPinTag.sponsoredOrEvent,
        visited: true,
      ),
      MapPinInfo(
        id: 'bar_marsella',
        name: 'Bar Marsella',
        level: 10,
        x: 0.62,
        y: 0.38,
        tag: MapPinTag.business,
        visited: true,
      ),
      MapPinInfo(
        id: 'sagrada',
        name: 'Sagrada Família',
        level: 18,
        x: 0.18,
        y: 0.55,
        tag: MapPinTag.pointOfInterest,
        visited: false,
      ),
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
      storyUserId: storyUserId,
      isFollowing: isFollowing ?? this.isFollowing,
      visits: visits,
      followers: followers,
      cities: cities,
      selectedTab: selectedTab ?? this.selectedTab,
      photos: photos,
      achievements: achievements,
      mapPins: mapPins,
    );
  }
}
