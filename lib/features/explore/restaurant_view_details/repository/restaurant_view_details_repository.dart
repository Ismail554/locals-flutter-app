import 'package:locals/core/network/api_client.dart';
import '../model/restaurant_view_details_model.dart';
import '../model/qr_checkin_result.dart';

abstract class RestaurantViewDetailsRepository {
  Future<RestaurantViewDetailsModel> load(String locationId);
  Future<void> savePlace(String locationId);
  Future<void> unsavePlace(String locationId);

  /// Direct GPS-based check-in for the "Been here" button.
  /// Hits POST /gamification/location-checkin/
  Future<QRCheckInResult> checkIn({
    required String placeId,
    required double latitude,
    required double longitude,
  });
}

class RestaurantViewDetailsRepositoryImpl
    implements RestaurantViewDetailsRepository {
  final ApiClient _client = ApiClient();

  @override
  Future<RestaurantViewDetailsModel> load(String locationId) async {
    final response = await _client.get('/places/$locationId/');
    return RestaurantViewDetailsModel.fromApi(response);
  }

  @override
  Future<void> savePlace(String locationId) async {
    await _client.post('/places/$locationId/save/', {});
  }

  @override
  Future<void> unsavePlace(String locationId) async {
    await _client.post('/places/$locationId/save/', {});
  }

  @override
  Future<QRCheckInResult> checkIn({
    required String placeId,
    required double latitude,
    required double longitude,
  }) async {
    final lat = double.parse(latitude.toStringAsFixed(6));
    final lng = double.parse(longitude.toStringAsFixed(6));

    final Object placeIdPayload = int.tryParse(placeId) ?? placeId;

    try {
      final response = await _client.post('/gamification/location-checkin/', {
        "place_id": placeIdPayload,
        "latitude": lat,
        "longitude": lng,
      });

      return QRCheckInResult.fromApi(response);
    } catch (e) {
      return const QRCheckInResult(
        success: false,
        message: "Failed to check in. Please try again.",
        status: "error",
      );
    }
  }
}