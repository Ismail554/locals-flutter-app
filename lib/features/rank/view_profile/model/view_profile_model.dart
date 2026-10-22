import 'package:flutter/material.dart';
import 'package:locals/shared/model/map_pin_info.dart';
import 'package:locals/shared/model/map_pin_tag.dart';
import 'package:locals/shared/model/check_in_photo_model.dart';

enum ViewProfileTab { photos, map, achievements }

class ViewProfileAchievement {
  final String id;
  final String title;
  final String description;
  final String iconUrl;
  final int pointsAwarded;
  final bool isUnlocked;

  const ViewProfileAchievement({
    required this.id,
    required this.title,
    required this.description,
    required this.iconUrl,
    required this.pointsAwarded,
    required this.isUnlocked,
  });

  factory ViewProfileAchievement.fromApi(Map<String, dynamic> json) {
    final achievement = json['achievement'] as Map<String, dynamic>? ?? json;

    return ViewProfileAchievement(
      id: achievement['id'].toString(),
      title: achievement['title'] ?? '',
      description: achievement['description'] ?? '',
      iconUrl: achievement['icon_url'] ?? '',
      pointsAwarded: achievement['points_awarded'] ?? 0,
      isUnlocked: json['earned_at'] != null,
    );
  }

  // ==========================
  // Keep old UI working
  // ==========================

  String get label => title;

  IconData get icon {
    switch (title.toLowerCase()) {
      case 'foodie':
        return Icons.restaurant;
      case 'explorer':
        return Icons.travel_explore;
      case 'photographer':
        return Icons.camera_alt;
      case 'night owl':
        return Icons.nightlight_round;
      case 'coffee lover':
        return Icons.coffee;
      case 'party animal':
        return Icons.celebration;
      default:
        return Icons.emoji_events;
    }
  }

  Color get color {
    switch (title.toLowerCase()) {
      case 'foodie':
        return Colors.orange;
      case 'explorer':
        return Colors.blue;
      case 'photographer':
        return Colors.purple;
      case 'night owl':
        return Colors.indigo;
      case 'coffee lover':
        return Colors.brown;
      case 'party animal':
        return Colors.pink;
      default:
        return Colors.amber;
    }
  }
}

class ViewProfileModel {
  final String id;
  final String name;
  final int level;
  final String location;
  final String? avatar;
  final bool hasStory;
  final String? storyUserId;
  final bool isFollowing;
  final int visits;
  final int followers;
  final int likes;
  final ViewProfileTab selectedTab;
  final List<CheckInPhoto> photos;
  final List<ViewProfileAchievement> achievements;
  final List<MapPinInfo> mapPins;
  final bool isBlocked;

  const ViewProfileModel({
    this.id = '',
    this.name = '',
    this.level = 1,
    this.location = '',
    this.avatar,
    this.hasStory = false,
    this.storyUserId,
    this.isFollowing = false,
    this.visits = 0,
    this.followers = 0,
    this.likes = 0,
    this.selectedTab = ViewProfileTab.photos,
    this.photos = const [],
    this.achievements = const [],
    this.mapPins = const [],
    this.isBlocked = false,
  });

  ViewProfileModel copyWith({
    bool? isFollowing,
    bool? isBlocked,
    ViewProfileTab? selectedTab,
    List<CheckInPhoto>? photos,
    List<MapPinInfo>? mapPins,
    List<ViewProfileAchievement>? achievements,
  }) {
    return ViewProfileModel(
      id: id,
      name: name,
      level: level,
      location: location,
      avatar: avatar,
      hasStory: hasStory,
      storyUserId: storyUserId,
      isFollowing: isFollowing ?? this.isFollowing,
      visits: visits,
      followers: followers,
      isBlocked: isBlocked ?? this.isBlocked,
      likes: likes,
      selectedTab: selectedTab ?? this.selectedTab,
      photos: photos ?? this.photos,
      achievements: achievements ?? this.achievements,
      mapPins: mapPins ?? this.mapPins,
    );
  }
}