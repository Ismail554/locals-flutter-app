import 'package:locals/core/network/api_client.dart';
import '../model/restaurant_view_details_model.dart';

abstract class RestaurantViewDetailsRepository {
  Future<RestaurantViewDetailsModel> load(String locationId);
  Future<void> savePlace(String locationId);
  Future<void> unsavePlace(String locationId);
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
}
