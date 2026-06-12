import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:locals/shared/theme/app_assets.dart';
import '../model/onboard_model.dart';
import '../repository/onboard_repository.dart';

class OnboardController extends ChangeNotifier {
  final OnboardRepository repo;
  final PageController pageController = PageController();

  OnboardModel state = OnboardModel(
    pages: const [
      OnboardPageData(
        imageAsset: AppAssets.onboardMap1,
        title: 'Discover authentic local places',
        subtitle:
            "Hand-picked spots with the locals' seal — the ones neighbors actually love.",
        buttonLabel: 'Continue',
      ),
      OnboardPageData(
        imageAsset: AppAssets.onboardMapPin2,
        title: 'Collect locations, earn points',
        subtitle:
            'Check in when you visit. Every authentic place becomes part of your map.',
        buttonLabel: 'Continue',
      ),
      OnboardPageData(
        imageAsset: AppAssets.onboardTrophy3,
        title: 'Level up, complete cities',
        subtitle:
            'Climb the ranks, unlock achievements, and chase 100% completion.',
        buttonLabel: 'Get Started',
      ),
      OnboardPageData(
        imageAsset: AppAssets.onboardLocation4,
        title: 'Find locals around you',
        subtitle:
            'We use your location to show authentic places nearby and to confirm your check-ins. Your location is never shared with other users.',
        buttonLabel: 'Allow location',
        showSkip: false,
        isLocationPage: true,
      ),
    ],
  );

  OnboardController(this.repo);

  int get carouselPageCount => state.pages.where((p) => !p.isLocationPage).length;

  void onPageChanged(int index) {
    state = state.copyWith(currentPage: index);
    notifyListeners();
  }

  void continuePressed(BuildContext context) {
    final page = state.pages[state.currentPage];
    if (page.isLocationPage) {
      context.go('/login');
      return;
    }

    if (state.currentPage == carouselPageCount - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
      return;
    }

    pageController.nextPage(
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOut,
    );
  }

  void skipPressed(BuildContext context) {
    context.go('/login');
  }

  void notNowPressed(BuildContext context) {
    context.go('/login');
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
