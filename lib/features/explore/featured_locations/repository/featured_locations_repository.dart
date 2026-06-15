import '../model/featured_locations_model.dart';

abstract class FeaturedLocationsRepository {
  FeaturedLocationsModel load();
}

class FeaturedLocationsRepositoryImpl implements FeaturedLocationsRepository {
  @override
  FeaturedLocationsModel load() => const FeaturedLocationsModel();
}
