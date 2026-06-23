import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:locals/features/map/map/model/map_screen_args.dart';
import 'package:locals/shared/components/image_view/check_in_image_view.dart';
import 'package:locals/shared/components/image_view/image_view_dialog.dart';
import '../model/restaurant_view_details_args.dart';
import '../model/restaurant_view_details_model.dart';
import '../repository/restaurant_view_details_repository.dart';
import '../view/widgets/share_location_bottom_sheet.dart';

class RestaurantViewDetailsController extends ChangeNotifier {
  final RestaurantViewDetailsRepository repo;
  final RestaurantViewDetailsArgs args;
  RestaurantViewDetailsModel restaurant;
  bool descriptionExpanded = false;

  RestaurantViewDetailsController(this.repo, this.args)
      : restaurant = repo.load(args.locationId);

  void toggleDescription() {
    descriptionExpanded = !descriptionExpanded;
    notifyListeners();
  }

  void toggleVisited() {
    restaurant = restaurant.copyWith(hasVisited: !restaurant.hasVisited);
    notifyListeners();
  }

  void toggleSaved() {
    restaurant = restaurant.copyWith(isSaved: !restaurant.isSaved);
    notifyListeners();
  }

  void checkIn(BuildContext context) {
    if (!restaurant.hasVisited) {
      restaurant = restaurant.copyWith(hasVisited: true);
      notifyListeners();
    }

    context.push(
      '/points',
      extra: restaurant.toPointsArgs(),
    );
  }

  void openDirections(BuildContext context) {
    context.go(
      '/map',
      extra: MapScreenArgs(
        focusedPinId: restaurant.mapPinId,
        highlightedLocation: restaurant.toMapLocation(),
      ),
    );
  }

  void share(BuildContext context) {
    ShareLocationBottomSheet.show(
      context,
      category: restaurant.category,
      name: restaurant.name,
      imageColor: restaurant.heroColor,
      shareUrl: restaurant.shareUrl,
    );
  }

  void openPhoto(BuildContext context, RestaurantPhoto photo) {
    ImageViewDialog.show(
      context,
      photo.toCheckInPhoto(_formatCategory(restaurant.category)),
      viewType: ImageViewType.checkIn,
    );
  }

  String _formatCategory(String category) {
    if (category.isEmpty) return category;
    return category[0] + category.substring(1).toLowerCase();
  }
}
