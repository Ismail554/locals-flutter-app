import 'package:flutter/material.dart';
import 'package:locals/shared/model/check_in_photo_model.dart';

class ProfileAchievement {
  final String label;
  final IconData icon;
  final Color color;

  const ProfileAchievement({
    required this.label,
    required this.icon,
    required this.color,
  });
}

class ProfileVisitTile extends CheckInPhoto {
  const ProfileVisitTile({
    required super.previewColor,
    required super.locationName,
    required super.timeAgo,
    required super.caption,
    required super.likes,
  });
}

class ProfileModel {
  final String name;
  final String location;
  final int level;
  final int points;
  final String levelTitle;
  final int pointsToNextLevel;
  final int visitCount;
  final int cities;
  final int followers;
  final List<ProfileAchievement> achievements;
  final List<ProfileVisitTile> latestVisits;

  const ProfileModel({
    this.name = 'Marta',
    this.location = 'Barcelona',
    this.level = 18,
    this.points = 6380,
    this.levelTitle = 'Neighborhood Scout',
    this.pointsToNextLevel = 620,
    this.visitCount = 63,
    this.cities = 3,
    this.followers = 456,
    this.achievements = const [
      ProfileAchievement(
        label: 'First Local',
        icon: Icons.eco_outlined,
        color: Color(0xFF4CD964),
      ),
      ProfileAchievement(
        label: '10 Visits',
        icon: Icons.location_on_outlined,
        color: Color(0xFFEA4D70),
      ),
      ProfileAchievement(
        label: 'Café Connoisseur',
        icon: Icons.coffee_outlined,
        color: Color(0xFF8B6914),
      ),
      ProfileAchievement(
        label: 'Night Owl',
        icon: Icons.nightlight_outlined,
        color: Color(0xFFFFB800),
      ),
    ],
    this.latestVisits = const [
      ProfileVisitTile(
        previewColor: Color(0xFFD4A574),
        locationName: 'Cafe',
        timeAgo: '2d ago',
        caption: 'Best cortado in the Born.',
        likes: 24,
      ),
      ProfileVisitTile(
        previewColor: Color(0xFF7EB8DA),
        locationName: 'Bakery',
        timeAgo: '4d ago',
        caption: 'Morning pastries run.',
        likes: 18,
      ),
      ProfileVisitTile(
        previewColor: Color(0xFFE8A0A0),
        locationName: 'Restaurant',
        timeAgo: '1w ago',
        caption: 'Dinner with friends.',
        likes: 31,
      ),
      ProfileVisitTile(
        previewColor: Color(0xFF9BB5CE),
        locationName: 'Park',
        timeAgo: '1w ago',
        caption: 'Sunset walk.',
        likes: 12,
      ),
      ProfileVisitTile(
        previewColor: Color(0xFFC4B5A0),
        locationName: 'Market',
        timeAgo: '2w ago',
        caption: 'Fresh produce haul.',
        likes: 9,
      ),
      ProfileVisitTile(
        previewColor: Color(0xFF8FA89A),
        locationName: 'Bar',
        timeAgo: '3w ago',
        caption: 'Friday night spot.',
        likes: 42,
      ),
    ],
  });

  String get shareUrl => 'https://local.app/p/${name.toLowerCase().replaceAll(' ', '')}';
}
