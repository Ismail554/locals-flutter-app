import 'package:locals/shared/theme/app_assets.dart';

enum MapPinTag {
  business,
  pointOfInterest,
  sponsoredOrEvent,
}

extension MapPinTagX on MapPinTag {
  String assetPath({required bool visited}) {
    return switch ((visited, this)) {
      (true, MapPinTag.business) => AppAssets.visitedBusiness,
      (true, MapPinTag.pointOfInterest) => AppAssets.visitedPointOfInterest,
      (true, MapPinTag.sponsoredOrEvent) => AppAssets.visitedSponsoredOrEvent,
      (false, MapPinTag.business) => AppAssets.unvisitedBusiness,
      (false, MapPinTag.pointOfInterest) => AppAssets.unvisitedPointOfInterest,
      (false, MapPinTag.sponsoredOrEvent) =>
        AppAssets.unvisitedSponsoredOrEvent,
    };
  }
}
