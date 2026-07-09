import 'package:flutter/material.dart';

enum RankScope { city, country, global, followers }

enum RankPeriod { weekly, monthly, allTime }

class PodiumUser {
  final int rank;
  final String name;
  final int score;
  final bool isCrowned;
  final String? storyUserId;
  final String? avatar;

  const PodiumUser({
    required this.rank,
    required this.name,
    required this.score,
    this.isCrowned = false,
    this.storyUserId,
    this.avatar,
  });
}

class RankEntry {
  final int rank;
  final String name;
  final int level;
  final int score;
  final bool isCurrentUser;
  final String? storyUserId;
  final String? avatar;

  const RankEntry({
    required this.rank,
    required this.name,
    required this.level,
    required this.score,
    this.isCurrentUser = false,
    this.storyUserId,
    this.avatar,
  });
}

class RankModel {
  final RankScope selectedScope;
  final RankPeriod selectedPeriod;
  final List<PodiumUser> podium;
  final List<RankEntry> entries;
  final RankEntry? currentUser;

  const RankModel({
    this.selectedScope = RankScope.city,
    this.selectedPeriod = RankPeriod.weekly,
    this.podium = const [],
    this.entries = const [],
    this.currentUser,
  });

  RankModel copyWith({
    RankScope? selectedScope,
    RankPeriod? selectedPeriod,
    List<PodiumUser>? podium,
    List<RankEntry>? entries,
    RankEntry? currentUser,
  }) {
    return RankModel(
      selectedScope: selectedScope ?? this.selectedScope,
      selectedPeriod: selectedPeriod ?? this.selectedPeriod,
      podium: podium ?? this.podium,
      entries: entries ?? this.entries,
      currentUser: currentUser ?? this.currentUser,
    );
  }
}