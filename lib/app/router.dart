import 'package:go_router/go_router.dart';
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
import '../features/map/map/model/map_mission_args.dart';
import '../features/explore/explore/view/explore_screen.dart';
import '../features/missions/missions/view/missions_screen.dart';
import '../features/rank/rank/view/rank_screen.dart';
import '../features/profile/profile/view/profile_screen.dart';
import '../features/profile/settings/view/settings_screen.dart';
import '../features/profile/privacy/view/privacy_screen.dart';
import '../features/profile/blocked_list/view/blocked_list_screen.dart';
import '../features/profile/my_map/view/my_map_screen.dart';
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

final appRouter = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(
      path: '/splash',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/onboard',
      builder: (context, state) => const OnboardScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/request_otp',
      builder: (context, state) => const RequestOtpScreen(),
    ),
    GoRoute(
      path: '/verify_otp',
      builder: (context, state) => const VerifyOtpScreen(),
    ),
    GoRoute(
      path: '/set_new_password',
      builder: (context, state) => const SetNewPasswordScreen(),
    ),
    GoRoute(
      path: '/signup',
      builder: (context, state) => const SignupScreen(),
    ),
    GoRoute(
      path: '/verify_account_otp',
      builder: (context, state) => const VerifyAccountOtpScreen(),
    ),
    ShellRoute(
      builder: (context, state, child) => AppScaffold(child: child),
      routes: [
        GoRoute(
          path: '/map',
          pageBuilder: (context, state) {
            final missionArgs = state.extra as MapMissionArgs?;
            return NoTransitionPage(
              child: MapScreen(missionArgs: missionArgs),
            );
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
      path: '/achievements',
      builder: (context, state) => const AchievementsScreen(),
    ),
    GoRoute(
      path: '/settings',
      builder: (context, state) => const SettingsScreen(),
    ),
    GoRoute(
      path: '/privacy',
      builder: (context, state) => const PrivacyScreen(),
    ),
    GoRoute(
      path: '/blocked_list',
      builder: (context, state) => const BlockedListScreen(),
    ),
    GoRoute(
      path: '/my_map',
      builder: (context, state) => const MyMapScreen(),
    ),
    GoRoute(
      path: '/manage_subscription',
      builder: (context, state) => const ManageSubscriptionScreen(),
    ),
    GoRoute(
      path: '/list',
      builder: (context, state) => const ListScreen(),
    ),
    GoRoute(
      path: '/saved_places',
      builder: (context, state) => const SavedPlacesScreen(),
    ),
    GoRoute(
      path: '/view_profile',
      builder: (context, state) => const ViewProfileScreen(),
    ),
    GoRoute(
      path: '/mission_details',
      builder: (context, state) {
        final missionId = state.extra as String?;
        return MissionDetailsScreen(missionId: missionId);
      },
    ),
    GoRoute(
      path: '/set_notification',
      builder: (context, state) => const SetNotificationScreen(),
    ),
    GoRoute(
      path: '/filters',
      builder: (context, state) {
        final args = state.extra as FiltersArgs?;
        return FiltersScreen(args: args);
      },
    ),
    GoRoute(
      path: '/notification',
      builder: (context, state) => const NotificationScreen(),
    ),
    GoRoute(
      path: '/map_search',
      builder: (context, state) {
        final initialQuery = state.extra as String? ?? '';
        return MapSearchScreen(initialQuery: initialQuery);
      },
    ),
    GoRoute(
      path: '/find_locals',
      builder: (context, state) {
        final args = state.extra! as FindLocalsArgs;
        return FindLocalsScreen(args: args);
      },
    ),
    GoRoute(
      path: '/story_view',
      builder: (context, state) {
        final args = state.extra! as StoryViewerArgs;
        return StoryViewScreen(args: args);
      },
    ),
  ],
);
