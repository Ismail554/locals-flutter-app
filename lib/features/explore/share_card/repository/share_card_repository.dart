import 'dart:io';

import 'package:locals/core/network/api_client.dart';
import 'package:locals/features/missions/check_in/model/checkin_model.dart';
import '../model/share_card_args.dart';
import '../model/share_card_model.dart';

abstract class ShareCardRepository {
  ShareCardModel load(ShareCardArgs args);

  Future<CheckInResult> submitCheckIn({
    required String placeId,
    required File imagePath,
    required String caption,
  });
}

class ShareCardRepositoryImpl implements ShareCardRepository {
  final ApiClient _client = ApiClient();

  @override
  ShareCardModel load(ShareCardArgs args) {
    return ShareCardModel(
      cityLabel: args.cityLabel,
      level: args.level,
      points: args.points,
      cityPercent: args.cityPercent,
      previewColor: args.previewColor,
    );
  }

  @override
  Future<CheckInResult> submitCheckIn({
    required String placeId,
    required File imagePath,
    required String caption,
  }) async {
    final response = await _client.postMultipart(
      '/social/checkins/',
      fields: {'place': placeId, 'caption': caption},
      files: {'image': imagePath},
    );
    return CheckInResult.fromJson(response);
  }
}