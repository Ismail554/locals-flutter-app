import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:locals/core/navigation/navigation_session.dart';
import 'package:locals/core/network/user_session.dart';
import 'package:locals/features/map/map/model/map_screen_args.dart';
import '../model/splash_model.dart';
import '../repository/splash_repository.dart';

class SplashController extends ChangeNotifier {
  final SplashRepository repo;
  SplashModel state = const SplashModel();

  SplashController(this.repo);

  bool _hasStarted = false;

  Future<void> initialize(BuildContext context) async {
    if (_hasStarted) return;
    _hasStarted = true;

    await Future<void>.delayed(const Duration(seconds: 2));

    if (!context.mounted) return;

    final isLoggedIn = await repo.isLoggedIn();

    if (!context.mounted) return;

    if (isLoggedIn) {
      await UserSession().fetchCurrentUser();

      if (!context.mounted) return;

      // If a direction was open when the app was last closed, reopen the map
      // straight into that route (like Uber / Pathao / Google Maps).
      final navigation = await NavigationSession().load();

      if (!context.mounted) return;

      if (navigation != null) {
        context.go(
          '/map',
          extra: MapScreenArgs(
            highlightedLocation: navigation.destination,
            focusedPinId: navigation.destination.mapPinId,
            showRoute: true,
            travelMode: navigation.travelMode,
            initialCenter: LatLng(
              navigation.destination.latitude,
              navigation.destination.longitude,
            ),
            initialZoom: 15.8,
          ),
        );
      } else {
        context.go('/map');
      }
    } else {
      context.go('/onboard');
    }
  }
}
