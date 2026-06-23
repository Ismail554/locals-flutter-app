import 'package:flutter/material.dart';
import 'package:locals/shared/components/image_view/check_in_image_view.dart';
import 'package:locals/shared/components/image_view/image_view_dialog.dart';
import 'package:locals/shared/model/check_in_photo_model.dart';
import '../../explore/model/explore_model.dart';

class LocalSharesController extends ChangeNotifier {
  final List<ExploreLocalShare> shares;

  LocalSharesController() : shares = _getAllLocalShares();

  static List<ExploreLocalShare> _getAllLocalShares() {
    return [
      ExploreLocalShare(
        id: 'ls1',
        imageColor: const Color(0xFFFFE4C4),
        userName: 'Marta Roig',
        timeAgo: '2d ago',
        caption: 'Best cortado in the Born.',
        likeCount: 24,
      ),
      ExploreLocalShare(
        id: 'ls2',
        imageColor: const Color(0xFFB0C4DE),
        userName: 'Joan Bosch',
        timeAgo: '5h ago',
        caption: 'Tokyo Skytree at sunset.',
        likeCount: 42,
      ),
      ExploreLocalShare(
        id: 'ls3',
        imageColor: const Color(0xFF4682B4),
        userName: 'Aina V.',
        timeAgo: '1d ago',
        caption: 'Cozy evening at the bar.',
        likeCount: 19,
      ),
      ExploreLocalShare(
        id: 'ls4',
        imageColor: const Color(0xFFD2B48C),
        userName: 'Marta Roig',
        timeAgo: '3h ago',
        caption: 'Fresh pastries for breakfast.',
        likeCount: 31,
      ),
      ExploreLocalShare(
        id: 'ls5',
        imageColor: const Color(0xFFFFDAB9),
        userName: 'Joan Bosch',
        timeAgo: '12h ago',
        caption: 'Tapas night with friends.',
        likeCount: 28,
      ),
      ExploreLocalShare(
        id: 'ls6',
        imageColor: const Color(0xFF708090),
        userName: 'Aina V.',
        timeAgo: 'Yesterday',
        caption: 'Beautiful restaurant interior.',
        likeCount: 15,
      ),
      // Duplicate some to match screenshot layout
      ExploreLocalShare(
        id: 'ls7',
        imageColor: const Color(0xFFFFE4C4),
        userName: 'Marta Roig',
        timeAgo: '2d ago',
        caption: 'Best cortado in the Born.',
        likeCount: 24,
      ),
      ExploreLocalShare(
        id: 'ls8',
        imageColor: const Color(0xFFB0C4DE),
        userName: 'Joan Bosch',
        timeAgo: '5h ago',
        caption: 'Amazing view from Skytree.',
        likeCount: 24,
      ),
    ];
  }

  void openLocalShareDetail(BuildContext context, ExploreLocalShare share) {
    // Reuse your existing ImageViewDialog
    final photo = CheckInPhoto(
      previewColor: share.imageColor,
      locationName: share.userName,
      timeAgo: share.timeAgo,
      caption: share.caption,
      likes: share.likeCount,
    );

    ImageViewDialog.show(context, photo, viewType: ImageViewType.localShare);
  }
}
