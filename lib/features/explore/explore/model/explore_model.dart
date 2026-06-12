import 'package:flutter/material.dart';

class StorySlide {
  final String id;
  final String? imagePath;
  final Color? placeholderColor;
  final DateTime createdAt;

  const StorySlide({
    required this.id,
    this.imagePath,
    this.placeholderColor,
    required this.createdAt,
  });

  StorySlide copyWith({
    String? imagePath,
    Color? placeholderColor,
  }) {
    return StorySlide(
      id: id,
      imagePath: imagePath ?? this.imagePath,
      placeholderColor: placeholderColor ?? this.placeholderColor,
      createdAt: createdAt,
    );
  }
}

class ExploreStory {
  final String id;
  final String name;
  final bool isYourStory;
  final List<StorySlide> slides;
  final bool isViewed;
  final bool isLikedByMe;
  final int likeCount;

  const ExploreStory({
    required this.id,
    required this.name,
    this.isYourStory = false,
    this.slides = const [],
    this.isViewed = false,
    this.isLikedByMe = false,
    this.likeCount = 0,
  });

  bool get hasStory => slides.isNotEmpty;

  ExploreStory copyWith({
    List<StorySlide>? slides,
    bool? isViewed,
    bool? isLikedByMe,
    int? likeCount,
  }) {
    return ExploreStory(
      id: id,
      name: name,
      isYourStory: isYourStory,
      slides: slides ?? this.slides,
      isViewed: isViewed ?? this.isViewed,
      isLikedByMe: isLikedByMe ?? this.isLikedByMe,
      likeCount: likeCount ?? this.likeCount,
    );
  }
}

class ExploreRankingUser {
  final int rank;
  final String name;
  final int level;
  final int points;

  const ExploreRankingUser({
    required this.rank,
    required this.name,
    required this.level,
    required this.points,
  });
}

class ExploreFollowUser {
  final String id;
  final String name;
  final int level;
  final bool isFollowing;

  const ExploreFollowUser({
    required this.id,
    required this.name,
    required this.level,
    this.isFollowing = false,
  });

  ExploreFollowUser copyWith({bool? isFollowing}) {
    return ExploreFollowUser(
      id: id,
      name: name,
      level: level,
      isFollowing: isFollowing ?? this.isFollowing,
    );
  }
}

class ExploreFeaturedLocation {
  final String id;
  final String category;
  final String name;
  final int points;
  final Color imageColor;

  const ExploreFeaturedLocation({
    required this.id,
    required this.category,
    required this.name,
    required this.points,
    required this.imageColor,
  });
}

class ExploreNewLocal {
  final String category;
  final String name;
  final String address;
  final Color imageColor;

  const ExploreNewLocal({
    required this.category,
    required this.name,
    required this.address,
    required this.imageColor,
  });
}

class ExploreFeaturedRoute {
  final String label;
  final String title;
  final String subtitle;
  final Color imageColor;

  const ExploreFeaturedRoute({
    required this.label,
    required this.title,
    required this.subtitle,
    required this.imageColor,
  });
}

class ExploreModel {
  static final List<ExploreStory> defaultStories = [
    const ExploreStory(id: 'you', name: 'Your story', isYourStory: true),
    ExploreStory(
      id: 'marta',
      name: 'Marta',
      slides: [
        StorySlide(
          id: 'm1',
          placeholderColor: const Color(0xFFD4A574),
          createdAt: DateTime(2026, 6, 12, 9, 30),
        ),
        StorySlide(
          id: 'm2',
          placeholderColor: const Color(0xFF7EB8DA),
          createdAt: DateTime(2026, 6, 12, 9, 31),
        ),
      ],
      likeCount: 24,
    ),
    ExploreStory(
      id: 'aina',
      name: 'Aina',
      slides: [
        StorySlide(
          id: 'a1',
          placeholderColor: const Color(0xFFE8A0A0),
          createdAt: DateTime(2026, 6, 12, 8, 15),
        ),
      ],
      likeCount: 12,
    ),
    ExploreStory(
      id: 'joan',
      name: 'Joan',
      slides: [
        StorySlide(
          id: 'j1',
          placeholderColor: const Color(0xFFC8D8B8),
          createdAt: DateTime(2026, 6, 11, 20, 0),
        ),
      ],
      isViewed: true,
      likeCount: 8,
    ),
    ExploreStory(
      id: 'paul',
      name: 'Paul',
      slides: [
        StorySlide(
          id: 'p1',
          placeholderColor: const Color(0xFFB8C8D8),
          createdAt: DateTime(2026, 6, 11, 18, 45),
        ),
      ],
      likeCount: 5,
    ),
  ];

  final List<ExploreStory> stories;
  final List<ExploreRankingUser> weeklyRanking;
  final List<ExploreFollowUser> followLocals;
  final List<ExploreFeaturedLocation> featuredLocations;
  final List<ExploreNewLocal> newLocals;
  final ExploreFeaturedRoute featuredRoute;

  ExploreModel({
    List<ExploreStory>? stories,
    this.weeklyRanking = const [
      ExploreRankingUser(rank: 1, name: 'Aina V.', level: 24, points: 12450),
      ExploreRankingUser(rank: 2, name: 'Marta Roig', level: 22, points: 11280),
      ExploreRankingUser(rank: 3, name: 'Joan P.', level: 20, points: 10720),
    ],
    this.followLocals = const [
      ExploreFollowUser(id: 'marta', name: 'Marta Roig', level: 14),
      ExploreFollowUser(id: 'aina', name: 'Aina V.', level: 24),
      ExploreFollowUser(id: 'joan', name: 'Joan P.', level: 18),
      ExploreFollowUser(id: 'nuria', name: 'Núria T.', level: 16),
    ],
    this.featuredLocations = const [
      ExploreFeaturedLocation(
        id: 'cafe',
        category: 'CAFE',
        name: 'Café del Born',
        points: 50,
        imageColor: Color(0xFFD4C4B0),
      ),
      ExploreFeaturedLocation(
        id: 'bar',
        category: 'BAR',
        name: 'Bar Marsella',
        points: 40,
        imageColor: Color(0xFFB8C8D8),
      ),
      ExploreFeaturedLocation(
        id: 'park',
        category: 'PARK',
        name: 'Parc Güell',
        points: 60,
        imageColor: Color(0xFFC8D8B8),
      ),
    ],
    this.newLocals = const [
      ExploreNewLocal(
        category: 'BAKERY',
        name: 'Forn Baluard',
        address: 'Carrer del Baluard 38',
        imageColor: Color(0xFFE8D8C8),
      ),
      ExploreNewLocal(
        category: 'MONUMENT',
        name: 'Sagrada Família',
        address: 'Carrer de Mallorca 401',
        imageColor: Color(0xFFD0D8E0),
      ),
    ],
    this.featuredRoute = const ExploreFeaturedRoute(
      label: 'SPONSORED ROUTE',
      title: 'Modernist Trail',
      subtitle: '7 stops · 500 pts',
      imageColor: Color(0xFF8A9AAA),
    ),
  }) : stories = stories ?? List<ExploreStory>.from(defaultStories);

  ExploreModel copyWith({
    List<ExploreStory>? stories,
    List<ExploreFollowUser>? followLocals,
  }) {
    return ExploreModel(
      stories: stories ?? this.stories,
      weeklyRanking: weeklyRanking,
      followLocals: followLocals ?? this.followLocals,
      featuredLocations: featuredLocations,
      newLocals: newLocals,
      featuredRoute: featuredRoute,
    );
  }
}
