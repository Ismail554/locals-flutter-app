import 'package:flutter/material.dart';
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

  void openDirections(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Opening directions to ${restaurant.address}')),
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
}
