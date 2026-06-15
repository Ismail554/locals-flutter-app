import 'package:flutter/material.dart';

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

class ProfileVisitTile {
  final Color color;

  const ProfileVisitTile({required this.color});
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
      ProfileVisitTile(color: Color(0xFFD4A574)),
      ProfileVisitTile(color: Color(0xFF7EB8DA)),
      ProfileVisitTile(color: Color(0xFFE8A0A0)),
      ProfileVisitTile(color: Color(0xFF9BB5CE)),
      ProfileVisitTile(color: Color(0xFFC4B5A0)),
      ProfileVisitTile(color: Color(0xFF8FA89A)),
    ],
  });

  String get shareUrl => 'https://local.app/p/${name.toLowerCase().replaceAll(' ', '')}';
}
