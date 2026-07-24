import 'package:flutter/material.dart';
import 'package:locals/core/network/user_session.dart';

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
      placeholderColor: placeholderColor ?? this.placeholderColor,
      createdAt: createdAt,
      isLikedByMe: isLikedByMe ?? this.isLikedByMe,
      likeCount: likeCount ?? this.likeCount,
    );
  }

  factory StorySlide.fromApi(Map<String, dynamic> json) {
    return StorySlide(
      id: json['id'].toString(),
      imageUrl: json['image'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
      isLikedByMe: json['liked_by_me'] as bool? ?? false,
      likeCount: json['like_count'] as int? ?? 0,
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

  factory ExploreStory.fromApi(Map<String, dynamic> json) {
    final slides = (json['stories'] as List? ?? [])
        .map((s) => StorySlide.fromApi(s as Map<String, dynamic>))
        .toList();

    final currentUserId = UserSession().currentUser?.id.toString();
    final rawStoryOwnerId = [
      json['id'],
      json['user_id'],
      json['owner_id'],
      json['author_id'],
      json['uploader_id'],
      (json['user'] as Map<String, dynamic>?)?['id'],
      (json['author'] as Map<String, dynamic>?)?['id'],
    ].firstWhere(
      (value) => value != null,
      orElse: () => null,
    );
    final storyOwnerId = rawStoryOwnerId?.toString();
    final isYourStory = currentUserId != null && storyOwnerId == currentUserId;

    return ExploreStory(
      id: storyOwnerId ?? json['id'].toString(),
      name: isYourStory
          ? 'Your story'
          : ((json['full_name'] as String?) ?? (json['name'] as String?) ?? ''),
      isYourStory: isYourStory,
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
  final String? avatarUrl;

  const ExploreFollowUser({
    required this.id,
    required this.name,
    this.level = 0,
    this.isFollowing = false,
    this.avatarUrl,
  });

  ExploreFollowUser copyWith({bool? isFollowing}) {
    return ExploreFollowUser(
      id: id,
      name: name,
      level: level,
      isFollowing: isFollowing ?? this.isFollowing,
      avatarUrl: avatarUrl,
    );
  }


  factory ExploreFollowUser.fromApi(Map<String, dynamic> json) {
    return ExploreFollowUser(
      id: json['id'].toString(),
      name: json['full_name'] as String? ?? 'Unknown',
      isFollowing: json['is_following'] as bool? ?? false,
      avatarUrl: json['avatar'] as String?,
    );
  }
}

class ExploreFeaturedLocation {
  final String id;
  final String category;
  final String name;
  final int points;
  final Color imageColor;
  final String? imageUrl; // ← NEW: from API `cover_photo`

  const ExploreFeaturedLocation({
    required this.id,
    required this.category,
    required this.name,
    required this.points,
    required this.imageColor,
    this.imageUrl,
  });

  /// Factory from `featured_locations` / `new_locals` API item
  factory ExploreFeaturedLocation.fromApi(Map<String, dynamic> json) {
    final category = json['category'] as Map<String, dynamic>?;
    return ExploreFeaturedLocation(
      id: json['id'].toString(),
      category: (category?['name'] as String? ?? '').toUpperCase(),
      name: json['name'] as String? ?? '',
      points: json['base_points'] as int? ?? 0,
      imageColor: const Color(0xFFD4C4B0),
      imageUrl: json['cover_photo'] as String?,
    );
  }
}

class ExploreNewLocal {
  final String id;
  final String category;
  final String name;
  final String address;
  final Color imageColor;
  final String? imageUrl; // ← NEW: from API `cover_photo`

  const ExploreNewLocal({
    required this.id,
    required this.category,
    required this.name,
    required this.address,
    required this.imageColor,
    this.imageUrl,
  });

  /// Factory from `new_locals` API item
  factory ExploreNewLocal.fromApi(Map<String, dynamic> json) {
    final category = json['category'] as Map<String, dynamic>?;
    return ExploreNewLocal(
      id: json['id'].toString(),
      category: (category?['name'] as String? ?? '').toUpperCase(),
      name: json['name'] as String? ?? '',
      address: json['address'] as String? ?? '',
      imageColor: const Color(0xFFE8D8C8),
      imageUrl: json['cover_photo'] as String?,
    );
  }
}

class ExploreFeaturedRoute {
  final String id;
  final String label;
  final String title;
  final String subtitle;
  final Color imageColor;
  final String? imageUrl; // ← NEW: from API `cover_photo`

  const ExploreFeaturedRoute({
    required this.id,
    required this.label,
    required this.title,
    required this.subtitle,
    required this.imageColor,
    this.imageUrl,
  });

  /// Factory from `featured_routes` API item
  factory ExploreFeaturedRoute.fromApi(Map<String, dynamic> json) {
    return ExploreFeaturedRoute(
      id: json['id'].toString(),
      label: 'FEATURED ROUTE',
      title: json['name'] as String? ?? '',
      subtitle: json['description'] as String? ?? '',
      imageColor: const Color(0xFF8A9AAA),
      imageUrl: json['cover_photo'] as String?,
    );
  }
}

class ExploreLocalShare {
  final String id;
  final Color imageColor;

  final String userName;
  final String userAvatarInitial;
  final String? userAvatarUrl;

  final String placeName;

  final String timeAgo;
  final String caption;
  final int likeCount;

  final String? imageUrl;
  final bool isLikedByUser;

  const ExploreLocalShare({
    required this.id,
    required this.imageColor,
    required this.userName,
    required this.placeName,
    this.userAvatarInitial = 'U',
    this.userAvatarUrl,
    required this.timeAgo,
    required this.caption,
    this.likeCount = 0,
    this.imageUrl,
    this.isLikedByUser = false,
  });

  ExploreLocalShare copyWith({
    bool? isLikedByUser,
    int? likeCount,
  }) {
    return ExploreLocalShare(
      id: id,
      imageColor: imageColor,
      userName: userName,
      placeName: placeName,
      userAvatarInitial: userAvatarInitial,
      userAvatarUrl: userAvatarUrl,
      timeAgo: timeAgo,
      caption: caption,
      likeCount: likeCount ?? this.likeCount,
      imageUrl: imageUrl,
      isLikedByUser: isLikedByUser ?? this.isLikedByUser,
    );
  }

  factory ExploreLocalShare.fromApi(Map<String, dynamic> json) {
    final author = json['author'] as Map<String, dynamic>?;

    final fullName = author?['full_name'] as String? ?? '';
    final avatar = author?['avatar'] as String?;

    return ExploreLocalShare(
      id: json['id'].toString(),
      imageColor: const Color(0xFFD4C4B0),

      userName: fullName,
      userAvatarInitial:
          fullName.isNotEmpty ? fullName[0].toUpperCase() : 'U',
      userAvatarUrl: avatar,

      placeName: json['place_name'] as String? ?? '',

      timeAgo: json['created_at_relative'] as String? ?? '',
      caption: json['caption'] as String? ?? '',
      likeCount: json['likes_count'] as int? ?? 0,
      imageUrl: json['full_image_url'] as String?,
      isLikedByUser: json['is_liked_by_user'] as bool? ?? false,
    );
  }
}
class ExploreModel {
  // "Your story" placeholder — always first in the list
  static const ExploreStory yourStoryPlaceholder = ExploreStory(
    id: 'you',
    name: 'Your story',
    isYourStory: true,
  );

  static List<ExploreStory> get defaultStories {
    return [yourStoryPlaceholder];
  }

  final List<ExploreStory> stories;
  final bool isLoadingStories;
  final bool isLoadingDashboard; // ← NEW: loading state for dashboard
  final List<ExploreRankingUser> weeklyRanking;
  final List<ExploreFollowUser> followLocals;
  final List<ExploreFeaturedLocation> featuredLocations;
  final List<ExploreNewLocal> newLocals;
  final ExploreFeaturedRoute? featuredRoute; // ← now nullable (until loaded)
  final List<ExploreLocalShare> localShares;

  ExploreModel({
    List<ExploreStory>? stories,
    this.isLoadingStories = false,
    this.isLoadingDashboard = false,
    this.weeklyRanking = const [],
    this.followLocals = const [],
    this.featuredLocations = const [],
    this.newLocals = const [],
    this.featuredRoute,
    this.localShares = const [],
  }) : stories = stories ?? List<ExploreStory>.from(defaultStories);

  ExploreModel copyWith({
    List<ExploreStory>? stories,
    bool? isLoadingStories,
    bool? isLoadingDashboard,
    List<ExploreFollowUser>? followLocals,
    List<ExploreLocalShare>? localShares,
    List<ExploreFeaturedLocation>? featuredLocations,
    List<ExploreNewLocal>? newLocals,
    ExploreFeaturedRoute? featuredRoute,
  }) {
    return ExploreModel(
      stories: stories ?? this.stories,
      isLoadingStories: isLoadingStories ?? this.isLoadingStories,
      isLoadingDashboard: isLoadingDashboard ?? this.isLoadingDashboard,
      followLocals: followLocals ?? this.followLocals,
      localShares: localShares ?? this.localShares,
      weeklyRanking: weeklyRanking,
      featuredLocations: featuredLocations ?? this.featuredLocations,
      newLocals: newLocals ?? this.newLocals,
      featuredRoute: featuredRoute ?? this.featuredRoute,
    );
  }
}