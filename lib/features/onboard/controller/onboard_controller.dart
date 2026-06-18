import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../model/onboard_model.dart';
import '../repository/onboard_repository.dart';

class OnboardController extends ChangeNotifier {
  final OnboardRepository repo;
  final PageController pageController = PageController();

  OnboardModel state = const OnboardModel();

  OnboardController(this.repo);

  void initPages(List<OnboardPageData> pages) {
    if (pages.isEmpty || state.pages.isNotEmpty) return;
    state = state.copyWith(pages: pages);
    notifyListeners();
  }

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
