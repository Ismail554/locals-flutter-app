import 'package:flutter/material.dart';

class StoryViewer {
  final String id;
  final String name;
  final DateTime viewedAt;
  final Color avatarColor;

  const StoryViewer({
    required this.id,
    required this.name,
    required this.viewedAt,
    this.avatarColor = const Color(0xFFD4A574),
  });
}

class StorySlide {
  static const storyLifetime = Duration(hours: 24);

  final String id;
  final String? imagePath;
  final String? imageUrl;
  final Color? placeholderColor;
  final DateTime createdAt;

  final bool isLikedByMe;
  final int likeCount;

  const StorySlide({
    required this.id,
  this.imagePath,
  this.imageUrl,
  this.placeholderColor,
  required this.createdAt,
  this.isLikedByMe = false,
  this.likeCount = 0,
  });

  DateTime get expiresAt => createdAt.add(storyLifetime);

  bool get isExpired => DateTime.now().isAfter(expiresAt);

  Duration get timeRemaining {
    final remaining = expiresAt.difference(DateTime.now());
    return remaining.isNegative ? Duration.zero : remaining;
  }

  String get remainingLabel {
    final remaining = timeRemaining;
    if (remaining == Duration.zero) return 'Expired';
    if (remaining.inMinutes < 1) return 'Expiring soon';
    if (remaining.inHours < 1) return '${remaining.inMinutes}m left';
    if (remaining.inHours < 24) return '${remaining.inHours}h left';
    return '${remaining.inDays}d left';
  }

  StorySlide copyWith({
  String? imagePath,
  String? imageUrl,
  Color? placeholderColor,
  bool? isLikedByMe,
  int? likeCount,
}) {

  return StorySlide(
    id: id,
    imagePath: imagePath ?? this.imagePath,
    imageUrl: imageUrl ?? this.imageUrl,
    placeholderColor:
        placeholderColor ?? this.placeholderColor,
    createdAt: createdAt,

    isLikedByMe:
        isLikedByMe ?? this.isLikedByMe,

    likeCount:
        likeCount ?? this.likeCount,
  );
}

factory StorySlide.fromApi(Map<String,dynamic> json){

 return StorySlide(

   id: json['id'].toString(),

   imageUrl: json['image'],

   createdAt:
     DateTime.parse(
       json['created_at'],
     ),

   isLikedByMe:
     json['liked_by_me'] ?? false,

   likeCount:
     json['like_count'] ?? 0,

 );

}
}

class ExploreStory {
  final String id;
  final String name;
  final bool isYourStory;
  final List<StorySlide> slides;
  final bool isViewed;
  final List<StoryViewer> viewers;
  final int? serverId;      

  const ExploreStory({
    required this.id,
    required this.name,
    this.isYourStory = false,
    this.slides = const [],
    this.isViewed = false,
    this.viewers = const [],
    this.serverId,        
  });

  List<StorySlide> get activeSlides =>
      slides.where((slide) => !slide.isExpired).toList();

  bool get hasStory => activeSlides.isNotEmpty;

ExploreStory copyWith({
  List<StorySlide>? slides,
  bool? isViewed,
  bool? isLikedByMe,
  int? likeCount,
  List<StoryViewer>? viewers,
}) {
  return ExploreStory(
    id: id,
    name: name,
    isYourStory: isYourStory,
    slides: slides ?? this.slides,
    isViewed: isViewed ?? this.isViewed,
    viewers: viewers ?? this.viewers,
    serverId: serverId,
  );
}

  /// Factory from API feed item
  factory ExploreStory.fromApi(Map<String, dynamic> json) {
    final slides = (json['stories'] as List)
        .map((s) => StorySlide.fromApi(s as Map<String, dynamic>))
        .toList();
    return ExploreStory(
      id: json['id'].toString(),
      name: json['full_name'] as String,
      slides: slides,
      isViewed: json['all_viewed'] as bool? ?? false,
      serverId: json['id'] as int?,
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
  final String id;
  final String category;
  final String name;
  final String address;
  final Color imageColor;

  const ExploreNewLocal({
    required this.id,
    required this.category,
    required this.name,
    required this.address,
    required this.imageColor,
  });
}

class ExploreFeaturedRoute {
  final String id;
  final String label;
  final String title;
  final String subtitle;
  final Color imageColor;

  const ExploreFeaturedRoute({
    required this.id,
    required this.label,
    required this.title,
    required this.subtitle,
    required this.imageColor,
  });
}

class ExploreLocalShare {
  final String id;
  final Color imageColor;
  final String userName;
  final String userAvatarInitial;
  final String timeAgo;
  final String caption;
  final int likeCount;

  const ExploreLocalShare({
    required this.id,
    required this.imageColor,
    required this.userName,
    this.userAvatarInitial = 'M',
    required this.timeAgo,
    required this.caption,
    this.likeCount = 24,
  });
}

class ExploreModel {
  // "Your story" placeholder — always first in the list
  static const ExploreStory yourStoryPlaceholder = ExploreStory(
    id: 'you',
    name: 'Your story',
    isYourStory: true,
  );

  static List<ExploreStory> get defaultStories {
    final now = DateTime.now();
    return [
      yourStoryPlaceholder,
      ExploreStory(
        id: 'marta',
        name: 'Marta',
        slides: [
          StorySlide(
            id: 'm1',
            placeholderColor: const Color(0xFFD4A574),
            createdAt: now.subtract(const Duration(hours: 2)),
          ),
          StorySlide(
            id: 'm2',
            placeholderColor: const Color(0xFF7EB8DA),
            createdAt: now.subtract(const Duration(hours: 1, minutes: 45)),
          ),
        ],
      ),
      ExploreStory(
        id: 'aina',
        name: 'Aina',
        slides: [
          StorySlide(
            id: 'a1',
            placeholderColor: const Color(0xFFE8A0A0),
            createdAt: now.subtract(const Duration(hours: 5)),
          ),
        ],
      ),
    ];
  }

  final List<ExploreStory> stories;
  final bool isLoadingStories; 
  final List<ExploreRankingUser> weeklyRanking;
  final List<ExploreFollowUser> followLocals;
  final List<ExploreFeaturedLocation> featuredLocations;
  final List<ExploreNewLocal> newLocals;
  final ExploreFeaturedRoute featuredRoute;
  final List<ExploreLocalShare> localShares;

  ExploreModel({
    List<ExploreStory>? stories,
    this.isLoadingStories = false,
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
        id: 'cafe_del_born',
        category: 'CAFE',
        name: 'Café del Born',
        points: 50,
        imageColor: Color(0xFFD4C4B0),
      ),
      ExploreFeaturedLocation(
        id: 'bar_marsella',
        category: 'BAR',
        name: 'Bar Marsella',
        points: 40,
        imageColor: Color(0xFFB8C8D8),
      ),
      ExploreFeaturedLocation(
        id: 'parc_guell',
        category: 'PARK',
        name: 'Parc Güell',
        points: 60,
        imageColor: Color(0xFFC8D8B8),
      ),
    ],
    this.newLocals = const [
      ExploreNewLocal(
        id: 'forn_baluard',
        category: 'BAKERY',
        name: 'Forn Baluard',
        address: 'Carrer del Baluard 38',
        imageColor: Color(0xFFE8D8C8),
      ),
      ExploreNewLocal(
        id: 'sagrada_familia',
        category: 'MONUMENT',
        name: 'Sagrada Família',
        address: 'Carrer de Mallorca 401',
        imageColor: Color(0xFFD0D8E0),
      ),
    ],
    this.featuredRoute = const ExploreFeaturedRoute(
      id: 'modernist_weekend',
      label: 'SPONSORED ROUTE',
      title: 'Modernist Trail',
      subtitle: '7 stops · 500 pts',
      imageColor: Color(0xFF8A9AAA),
    ),
    required this.localShares,
  }) : stories = stories ?? List<ExploreStory>.from(defaultStories);

  ExploreModel copyWith({
    List<ExploreStory>? stories,
    bool? isLoadingStories,
    List<ExploreFollowUser>? followLocals,
    List<ExploreLocalShare>? localShares,
  }) {
    return ExploreModel(
      stories: stories ?? this.stories,
      isLoadingStories: isLoadingStories ?? this.isLoadingStories,
      followLocals: followLocals ?? this.followLocals,
      localShares: localShares ?? this.localShares,
      weeklyRanking: weeklyRanking,
      featuredLocations: featuredLocations,
      newLocals: newLocals,
      featuredRoute: featuredRoute,
    );
  }
}