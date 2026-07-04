import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:locals/features/explore/explore/model/explore_map_args.dart';
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

  RestaurantViewDetailsModel? restaurant;
  bool isLoading = true;
  String? errorMessage;
  bool descriptionExpanded = false;

  RestaurantViewDetailsController(this.repo, this.args) {
    _load();
  }

  Future<void> _load() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      restaurant = await repo.load(args.locationId);
    } catch (e) {
      print('Restaurant detail load error: $e');
      errorMessage = 'Failed to load details. Please try again.';
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> refresh() => _load();

  void toggleDescription() {
    descriptionExpanded = !descriptionExpanded;
    notifyListeners();
  }

  void toggleSaved() {
    if (restaurant == null) return;
    restaurant = restaurant!.copyWith(isSaved: !restaurant!.isSaved);
    notifyListeners();
  }

  void checkIn(BuildContext context) {
    if (restaurant == null) return;
    if (!restaurant!.hasVisited) {
      restaurant = restaurant!.copyWith(hasVisited: true);
      notifyListeners();
    }
    context.push('/points', extra: restaurant!.toPointsArgs());
  }

void openDirections(BuildContext context) {
  if (restaurant == null) return;

  context.go(
    "/map",
    extra: MapScreenArgs(
      focusedPinId: restaurant!.mapPinId,
      highlightedLocation: restaurant!.toMapLocation(),
      showRoute: true,
    ),
  );
}

  void share(BuildContext context) {
    if (restaurant == null) return;
    ShareLocationBottomSheet.show(
      context,
      category: restaurant!.category,
      name: restaurant!.name,
      imageColor: restaurant!.heroColor,
      shareUrl: restaurant!.shareUrl,
    );
  }

  void openPhoto(BuildContext context, RestaurantPhoto photo) {
    if (restaurant == null) return;
    ImageViewDialog.show(
      context,
      photo.toCheckInPhoto(_formatCategory(restaurant!.category)),
      viewType: ImageViewType.checkIn,
    );
  }

  String _formatCategory(String category) {
    if (category.isEmpty) return category;
    return category[0] + category.substring(1).toLowerCase();
  }
}