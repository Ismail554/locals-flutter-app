import '../model/restaurant_view_details_model.dart';

abstract class RestaurantViewDetailsRepository {
  RestaurantViewDetailsModel load(String locationId);
}

class RestaurantViewDetailsRepositoryImpl
    implements RestaurantViewDetailsRepository {
  @override
  RestaurantViewDetailsModel load(String locationId) {
    return RestaurantViewDetailsModel.byId(locationId);
  }
}
