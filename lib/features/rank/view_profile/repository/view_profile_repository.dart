import 'package:flutter/material.dart';
import 'package:locals/core/network/api_client.dart';
import 'package:locals/shared/model/check_in_photo_model.dart';
import 'package:locals/shared/model/map_pin_info.dart';
import 'package:locals/shared/model/map_pin_tag.dart';
import '../model/view_profile_model.dart';

abstract class ViewProfileRepository {
  Future<ViewProfileModel> fetchProfile(String userId);
  Future<void> blockUser(String userId);
}

class ViewProfileRepositoryImpl implements ViewProfileRepository {
  final ApiClient _client = ApiClient();

  @override
  Future<ViewProfileModel> fetchProfile(String userId) async {
    final profileRes =
        await _client.get('/social/profiles/$userId/') as Map<String, dynamic>;

    // 2. Map Pins
    final dynamic mapResponse = await _client.get('/social/users/$userId/map/');

    List<dynamic> mapRaw = [];

    if (mapResponse is List) {
      mapRaw = mapResponse;
    } else if (mapResponse is Map<String, dynamic>) {
      mapRaw = (mapResponse['results'] as List?) ?? [];
    }

    final List<MapPinInfo> mapPins = mapRaw.map<MapPinInfo>((item) {
      final map = item as Map<String, dynamic>;

      return MapPinInfo(
        id: map['place_id'].toString(),
        name: map['place_name']?.toString() ?? 'Visited Place',
        level: 1,
        lat: double.tryParse(map['latitude'].toString()) ?? 41.3851,
        lng: double.tryParse(map['longitude'].toString()) ?? 2.1734,
        tag: MapPinTag.business,
        visited: true,
        category: map['category_slug'] as String?,
      );
    }).toList();

    // 3. Check-ins (Photos)
    final dynamic checkinsRes = await _client.get(
      '/social/users/$userId/checkins/?page=1',
    );

    List<dynamic> checkinsRaw = [];

    if (checkinsRes is Map<String, dynamic>) {
      checkinsRaw = (checkinsRes['results'] as List?) ?? [];
    } else if (checkinsRes is List) {
      checkinsRaw = checkinsRes;
    }

    final List<CheckInPhoto> photos = checkinsRaw.map<CheckInPhoto>((item) {
      final map = item as Map<String, dynamic>;

      return CheckInPhoto(
        id: map['id'].toString(),
        imageUrl: map['image'] as String?,
        caption: map['caption'] as String? ?? '',
        locationName: map['place_name']?.toString() ?? '',
        timeAgo: map['created_at_relative'] as String? ?? '',
        likes: map['likes_count'] as int? ?? 0,
        previewColor: const Color(0xFFD4A574),
      );
    }).toList();

    // 4. Achievements
    final dynamic achievementsRes = await _client.get(
      '/gamification/users/$userId/achievements/',
    );

    List<dynamic> achievementsRaw = [];

    if (achievementsRes is List) {
      achievementsRaw = achievementsRes;
    } else if (achievementsRes is Map<String, dynamic>) {
      achievementsRaw = (achievementsRes['results'] as List?) ?? [];
    }

    final List<ViewProfileAchievement> achievements = achievementsRaw
        .map<ViewProfileAchievement>((item) {
          return ViewProfileAchievement.fromApi(item as Map<String, dynamic>);
        })
        .toList();

    return ViewProfileModel(
      id: profileRes['id'].toString(),
      name: profileRes['full_name'] as String? ?? 'User',
      level: profileRes['level'] as int? ?? 1,
      location: profileRes['location_city'] as String? ?? 'Barcelona',
      avatar: profileRes['avatar'] as String?,
      hasStory: true,
      storyUserId: userId,
      isFollowing: profileRes['is_following'] as bool? ?? false,
      visits: profileRes['visits_count'] as int? ?? 0,
      followers: profileRes['followers_count'] as int? ?? 0,
      likes: profileRes['likes_count'] as int? ?? 0,
      selectedTab: ViewProfileTab.photos,
      photos: photos,
      mapPins: mapPins,
      achievements: achievements,
    );
  }
  
  @override
  Future<void> blockUser(String userId) async{
    await _client.post('/social/profiles/$userId/block/', {});
  }
}
