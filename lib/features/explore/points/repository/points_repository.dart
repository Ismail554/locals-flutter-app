import '../model/points_args.dart';
import '../model/points_model.dart';

abstract class PointsRepository {
  PointsModel load(PointsArgs args);
}

class PointsRepositoryImpl implements PointsRepository {
  @override
  PointsModel load(PointsArgs args) {
    return PointsModel(
      locationName: args.locationName,
      points: args.points,
      cityName: args.cityName,
      cityProgress: args.cityProgress,
    );
  }
}
