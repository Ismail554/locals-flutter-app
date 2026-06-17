import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:locals/shared/theme/app_colors.dart';
import '../controller/restaurant_view_details_controller.dart';
import '../model/restaurant_view_details_args.dart';
import '../repository/restaurant_view_details_repository.dart';
import 'widgets/restaurant_action_buttons.dart';
import 'widgets/restaurant_description_section.dart';
import 'widgets/restaurant_hero_header.dart';
import 'widgets/restaurant_info_rows.dart';
import 'widgets/restaurant_photos_section.dart';
import 'widgets/restaurant_visitors_section.dart';

class RestaurantViewDetailsScreen extends StatelessWidget {
  final RestaurantViewDetailsArgs? args;

  const RestaurantViewDetailsScreen({super.key, this.args});

  @override
  Widget build(BuildContext context) {
    final resolvedArgs = args ??
        (GoRouterState.of(context).extra as RestaurantViewDetailsArgs?);

    return ChangeNotifierProvider(
      create: (_) => RestaurantViewDetailsController(
        RestaurantViewDetailsRepositoryImpl(),
        resolvedArgs ?? const RestaurantViewDetailsArgs(locationId: 'forn_baluard'),
      ),
      child: const _RestaurantViewDetailsView(),
    );
  }
}

class _RestaurantViewDetailsView extends StatelessWidget {
  const _RestaurantViewDetailsView();

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<RestaurantViewDetailsController>();
    final restaurant = controller.restaurant;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        children: [
          RestaurantHeroHeader(
            restaurant: restaurant,
            onBack: () => context.pop(),
            onShare: () => controller.share(context),
            onSave: controller.toggleSaved,
          ),
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 24.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RestaurantDescriptionSection(
                    shortDescription: restaurant.shortDescription,
                    fullDescription: restaurant.fullDescription,
                    isExpanded: controller.descriptionExpanded,
                    onToggle: controller.toggleDescription,
                  ),
                  SizedBox(height: 20.h),
                  RestaurantInfoRows(
                    address: restaurant.address,
                    hours: restaurant.hours,
                    instagramHandle: restaurant.instagramHandle,
                  ),
                  SizedBox(height: 20.h),
                  RestaurantActionButtons(
                    hasVisited: restaurant.hasVisited,
                    onBeenHereTap: () => controller.checkIn(context),
                    onDirectionsTap: () => controller.openDirections(context),
                  ),
                  SizedBox(height: 24.h),
                  RestaurantPhotosSection(
                    photos: restaurant.photos,
                    onPhotoTap: (photo) => controller.openPhoto(context, photo),
                  ),
                  SizedBox(height: 24.h),
                  RestaurantVisitorsSection(
                    visitorCount: restaurant.visitorCount,
                    avatarColors: restaurant.visitorAvatarColors,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
