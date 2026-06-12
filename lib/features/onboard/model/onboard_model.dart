class OnboardPageData {
  final String imageAsset;
  final String title;
  final String subtitle;
  final String buttonLabel;
  final bool showSkip;
  final bool isLocationPage;

  const OnboardPageData({
    required this.imageAsset,
    required this.title,
    required this.subtitle,
    required this.buttonLabel,
    this.showSkip = true,
    this.isLocationPage = false,
  });
}

class OnboardModel {
  final int currentPage;
  final List<OnboardPageData> pages;

  const OnboardModel({
    this.currentPage = 0,
    this.pages = const [],
  });

  OnboardModel copyWith({
    int? currentPage,
    List<OnboardPageData>? pages,
  }) {
    return OnboardModel(
      currentPage: currentPage ?? this.currentPage,
      pages: pages ?? this.pages,
    );
  }
}
