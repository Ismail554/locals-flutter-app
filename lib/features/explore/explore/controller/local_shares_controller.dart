import 'package:flutter/material.dart';
import 'package:locals/core/network/api_client.dart';
import 'package:locals/shared/components/image_view/check_in_image_view.dart';
import 'package:locals/shared/components/image_view/image_view_dialog.dart';
import 'package:locals/shared/model/check_in_photo_model.dart';
import '../../explore/model/explore_model.dart';

class LocalSharesController extends ChangeNotifier {
  List<ExploreLocalShare> shares = const [];
  bool isLoading = false;
  String? errorMessage;

  final ApiClient _client = ApiClient();

  LocalSharesController() {
    _loadFeed();
  }

  Future<void> _loadFeed() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final response = await _client.get('/social/checkins/feed/');
      final results = response['results'] as List? ?? [];
      shares = results
          .map((item) => _checkinToLocalShare(item as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print('LocalShares feed error: $e');
      errorMessage = 'Failed to load. Please try again.';
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> refresh() => _loadFeed();

  /// Maps a `/social/checkins/feed/` item to `ExploreLocalShare`.
  ExploreLocalShare _checkinToLocalShare(Map<String, dynamic> json) {
    final author = json['author'] as Map<String, dynamic>?;

    final authorName = author?['full_name'] as String? ?? '';
    final authorAvatar = author?['avatar'] as String?;

    return ExploreLocalShare(
      id: json['id'].toString(),
      imageColor: const Color(0xFFD4C4B0),

      userName: authorName,
      userAvatarInitial: authorName.isNotEmpty
          ? authorName[0].toUpperCase()
          : 'U',
      userAvatarUrl: authorAvatar,

      placeName: json['place_name'] as String? ?? '',

      timeAgo: json['created_at_relative'] as String? ?? '',
      caption: json['caption'] as String? ?? '',
      likeCount: json['likes_count'] as int? ?? 0,
      imageUrl: json['full_image_url'] as String?,
      isLikedByUser: json['is_liked_by_user'] as bool? ?? false,
    );
  }

  void openLocalShareDetail(BuildContext context, ExploreLocalShare share) {
    final photo = CheckInPhoto(
      previewColor: share.imageColor,
      locationName: share.userName,
      timeAgo: share.timeAgo,
      caption: share.caption,
      likes: share.likeCount,
      userInitial: share.userAvatarInitial,
    );

    ImageViewDialog.show(context, photo, viewType: ImageViewType.localShare);
  }
}
