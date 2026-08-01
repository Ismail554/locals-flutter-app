import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:locals/features/explore/explore/view/local_shares_screen.dart';
import 'package:locals/features/explore/restaurant_view_details/model/qr_checkin_result.dart';
import 'package:locals/features/explore/restaurant_view_details/model/qr_discount_result.dart';
import 'package:locals/features/explore/restaurant_view_details/view/qr_discount_status_screen.dart';
import 'package:locals/features/explore/restaurant_view_details/view/qr_scan_screen.dart';
import 'package:locals/features/explore/restaurant_view_details/view/qr_scan_status_screen.dart';
import 'app_scaffold.dart';
import '../features/splash/view/splash_screen.dart';
import '../features/onboard/view/onboard_screen.dart';
import '../features/login/login/view/login_screen.dart';
import '../features/login/request_otp/view/request_otp_screen.dart';
import '../features/login/verify_otp/view/verify_otp_screen.dart';
import '../features/login/set_new_password/view/set_new_password_screen.dart';
import '../features/account_create/signup/view/signup_screen.dart';
import '../features/account_create/verify_account_otp/view/verify_account_otp_screen.dart';
import '../features/map/map/view/map_screen.dart';
import '../features/map/map/model/map_screen_args.dart';
import '../features/explore/explore/view/explore_screen.dart';
import '../features/missions/missions/view/missions_screen.dart';
import '../features/rank/rank/view/rank_screen.dart';
import '../features/profile/profile/view/profile_screen.dart';
import '../features/profile/settings/view/settings_screen.dart';
import '../features/profile/privacy/view/privacy_screen.dart';
import '../features/profile/blocked_list/view/blocked_list_screen.dart';
import '../features/profile/my_map/view/my_map_screen.dart';
import '../features/rank/view_profile/model/view_profile_args.dart';
import '../features/rank/view_profile/view/view_profile_screen.dart';
import '../features/missions/mission_details/view/mission_details_screen.dart';
import '../features/profile/set_notification/view/set_notification_screen.dart';
import '../features/map/filters/view/filters_screen.dart';
import '../features/map/filters/model/filters_model.dart';
import '../features/map/notification/view/notification_screen.dart';
import '../features/map/search/view/map_search_screen.dart';
import '../features/profile/manage_subscription/view/manage_subscription_screen.dart';
import '../features/profile/list/view/list_screen.dart';
import '../features/profile/saved_places/view/saved_places_screen.dart';
import '../features/explore/find_locals/view/find_locals_screen.dart';
import '../features/explore/find_locals/model/find_locals_args.dart';
import '../features/explore/story_view/view/story_view_screen.dart';
import '../features/explore/story_view/model/story_view_args.dart';
import '../features/missions/achievements/view/achievements_screen.dart';
import '../features/explore/featured_locations/view/featured_locations_screen.dart';
import '../features/explore/events_routes/view/events_routes_screen.dart';
import '../features/explore/join_event/view/join_event_screen.dart';
import '../features/explore/join_event/model/join_event_args.dart';
import '../features/explore/restaurant_view_details/view/restaurant_view_details_screen.dart';
import '../features/explore/restaurant_view_details/model/restaurant_view_details_args.dart';
import '../features/explore/events_progress_map/view/events_progress_map_screen.dart';
import '../features/explore/events_progress_map/model/events_progress_map_args.dart';
import '../features/explore/points/view/points_screen.dart';
import '../features/explore/points/model/points_args.dart';
import '../features/explore/share_card/view/share_card_screen.dart';
import '../features/explore/share_card/model/share_card_args.dart';
import '../features/profile/privacy_data/view/privacy_data_screen.dart';
import '../features/profile/edit_profile/view/edit_profile_screen.dart';
import '../features/profile/help_support/view/help_support_screen.dart';
import '../features/profile/privacy_policy/view/privacy_policy_screen.dart';
import '../features/profile/terms_of_use/view/terms_of_use_screen.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
final _shellNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'shell');

final appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/splash',
  routes: [
    GoRoute(path: '/splash', builder: (context, state) => const SplashScreen()),
    GoRoute(
      path: '/onboard',
      builder: (context, state) => const OnboardScreen(),
    ),
    GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
    GoRoute(
      path: '/request_otp',
      builder: (context, state) => const RequestOtpScreen(),
    ),
    GoRoute(
      path: '/verify_otp',
      builder: (context, state) {
        final email = state.extra as String? ?? '';
        return VerifyOtpScreen(email: email);
      },
    ),

    GoRoute(
      path: '/set_new_password',
      builder: (context, state) {
        final args = state.extra as Map<String, String>? ?? {};
        return SetNewPasswordScreen(
          email: args['email'] ?? '',
          resetToken: args['reset_token'] ?? '',
        );
      },
    ),
    GoRoute(path: '/signup', builder: (context, state) => const SignupScreen()),
    GoRoute(
      path: '/verify_account_otp',
      builder: (context, state) {
        final email = state.extra as String? ?? '';
        return VerifyAccountOtpScreen(email: email);
      },
    ),
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) => AppScaffold(child: child),
      routes: [
        GoRoute(
          path: '/map',
          pageBuilder: (context, state) {
            final screenArgs = MapScreenArgs.fromExtra(state.extra);
            return NoTransitionPage(child: MapScreen(screenArgs: screenArgs));
          },
        ),
        GoRoute(
          path: '/explore',
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: ExploreScreen()),
        ),
        GoRoute(
          path: '/missions',
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: MissionsScreen()),
        ),
        GoRoute(
          path: '/rank',
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: RankScreen()),
        ),
        GoRoute(
          path: '/profile',
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: ProfileScreen()),
        ),
      ],
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/featured_locations',
      builder: (context, state) => const FeaturedLocationsScreen(),
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/events_routes',
      builder: (context, state) => const EventsRoutesScreen(),
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/join_event',
      builder: (context, state) {
        final args = state.extra as JoinEventArgs?;
        return JoinEventScreen(args: args);
      },
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/restaurant_view_details',
      builder: (context, state) {
        final args = state.extra as RestaurantViewDetailsArgs?;
        return RestaurantViewDetailsScreen(args: args);
      },
    ),
    GoRoute(
      path: "/l/:id",

      builder: (context, state) {
        return RestaurantViewDetailsScreen(
          args: RestaurantViewDetailsArgs(
            locationId: state.pathParameters["id"]!,
          ),
        );
      },
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/events_progress_map',
      builder: (context, state) {
        final args = state.extra as EventsProgressMapArgs?;
        return EventsProgressMapScreen(args: args);
      },
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/points',
      builder: (context, state) {
        final args = state.extra as PointsArgs?;
        return PointsScreen(args: args);
      },
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/share_card',
      builder: (context, state) {
        final args = state.extra as ShareCardArgs?;
        return ShareCardScreen(args: args);
      },
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/privacy_policy',
      builder: (context, state) => const PrivacyPolicyScreen(),
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/terms_of_use',
      builder: (context, state) => const TermsOfUseScreen(),
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/privacy_data',
      builder: (context, state) => const PrivacyDataScreen(),
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/edit_profile',
      builder: (context, state) => const EditProfileScreen(),
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/help_support',
      builder: (context, state) => const HelpSupportScreen(),
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/achievements',
      builder: (context, state) => const AchievementsScreen(),
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/settings',
      builder: (context, state) => const SettingsScreen(),
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/privacy',
      builder: (context, state) => const PrivacyScreen(),
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/blocked_list',
      builder: (context, state) => const BlockedListScreen(),
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/my_map',
      builder: (context, state) => const MyMapScreen(),
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/manage_subscription',
      builder: (context, state) => const ManageSubscriptionScreen(),
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/list',
      builder: (context, state) => const ListScreen(),
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/saved_places',
      builder: (context, state) => const SavedPlacesScreen(),
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/view_profile',
      builder: (context, state) {
        final args = state.extra as ViewProfileArgs?;
        return ViewProfileScreen(args: args);
      },
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/mission_details',
      builder: (context, state) {
        final missionId = state.extra as String?;
        return MissionDetailsScreen(missionId: missionId);
      },
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/set_notification',
      builder: (context, state) => const SetNotificationScreen(),
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/filters',
      builder: (context, state) {
        final args = state.extra as FiltersArgs?;
        return FiltersScreen(args: args);
      },
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/notification',
      builder: (context, state) => const NotificationScreen(),
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/map_search',
      builder: (context, state) {
        final initialQuery = state.extra as String? ?? '';
        return MapSearchScreen(initialQuery: initialQuery);
      },
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/find_locals',
      builder: (context, state) {
        final args = state.extra! as FindLocalsArgs;
        return FindLocalsScreen(args: args);
      },
    ),
    GoRoute(
      path: '/local_shares',
      builder: (context, state) => const LocalSharesScreen(),
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/story_view',
      builder: (context, state) {
        final args = state.extra! as StoryViewerArgs;
        return StoryViewScreen(args: args);
      },
    ),
    GoRoute(
      path: '/qr-scan',
      builder: (context, state) => const QRScanScreen(),
    ),
    GoRoute(
      path: '/qr-discount-result',
      builder: (context, state) =>
          QRDiscountStatusScreen(result: state.extra as QRDiscountResult),
    ),
    GoRoute(
      path: '/qr-scan-status',
      builder: (context, state) =>
          QRScanStatusScreen(result: state.extra as QRCheckInResult),
    ),
  ],
);
