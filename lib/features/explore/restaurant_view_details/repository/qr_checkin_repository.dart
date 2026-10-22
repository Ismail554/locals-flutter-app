import 'package:locals/core/network/api_client.dart';
import 'package:locals/features/explore/restaurant_view_details/model/qr_checkin_result.dart';

abstract class QRCheckInRepository {
  Future<QRCheckInResult> qrCheckIn({
    required String qrToken,
    required double latitude,
    required double longitude,
  });
}

class QRCheckInRepositoryImpl implements QRCheckInRepository {
  final ApiClient _client = ApiClient();

  @override
  Future<QRCheckInResult> qrCheckIn({
    required String qrToken,
    required double latitude,
    required double longitude,
  }) async {
    final lat = double.parse(latitude.toStringAsFixed(6));
    final lng = double.parse(longitude.toStringAsFixed(6));

    try {
      final response = await _client.post('/gamification/qr-checkin/', {
        "qr_token": qrToken,
        "latitude": lat,
        "longitude": lng,
      });

      return QRCheckInResult.fromApi(response);
    } catch (e) {
      // Return failure result on error
      return QRCheckInResult(
        success: false,
        message: "Failed to process QR check-in. Please try again.",
        status: "error",
      );
    }
  }
}
