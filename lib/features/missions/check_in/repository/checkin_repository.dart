import 'dart:io';
import 'package:locals/core/network/api_client.dart';
import '../model/checkin_model.dart';

abstract class CheckInRepository {
  Future<CheckInResult> checkIn({
    required String placeId,
    required File image,
    required String caption,
  });
}

class CheckInRepositoryImpl implements CheckInRepository {
  final ApiClient _client = ApiClient();

  @override
  Future<CheckInResult> checkIn({
    required String placeId,
    required File image,
    required String caption,
  }) async {
    final response = await _client.postMultipart(
      '/social/checkins/',
      fields: {'place': placeId, 'caption': caption},
      files: {'image': image},
    );
    return CheckInResult.fromJson(response);
  }
}