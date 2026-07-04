import 'package:locals/core/network/api_client.dart';
import '../model/restaurant_view_details_model.dart';

abstract class RestaurantViewDetailsRepository {
  Future<RestaurantViewDetailsModel> load(String locationId);
}

class RestaurantViewDetailsRepositoryImpl
    implements RestaurantViewDetailsRepository {
  final ApiClient _client = ApiClient();

  @override
  Future<RestaurantViewDetailsModel> load(String locationId) async {
    final response = await _client.get('/places/$locationId/');
    return RestaurantViewDetailsModel.fromApi(response);
  }
}