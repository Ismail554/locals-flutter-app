import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:locals/core/localization/l10n_extensions.dart';
import 'package:locals/core/localization/onboard_l10n.dart';
import 'package:locals/shared/components/onboard_page_indicator.dart';
import 'package:locals/shared/components/primary_button.dart';
import 'package:locals/shared/components/secondary_outlined_button.dart';
import 'package:locals/shared/theme/app_colors.dart';
import '../controller/onboard_controller.dart';
import '../repository/onboard_repository.dart';
import 'widgets/onboard_carousel_page.dart';
import 'widgets/onboard_location_page.dart';
import 'widgets/onboard_top_bar.dart';

class OnboardScreen extends StatefulWidget {
  const OnboardScreen({super.key});

  @override
  State<OnboardScreen> createState() => _OnboardScreenState();
}

class _OnboardScreenState extends State<OnboardScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => OnboardController(OnboardRepositoryImpl()),
      child: const _OnboardView(),
    );
  }
}

class _OnboardView extends StatefulWidget {
  const _OnboardView();

  @override
  State<_OnboardView> createState() => _OnboardViewState();
}

class _OnboardViewState extends State<_OnboardView> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final controller = context.read<OnboardController>();
    if (controller.state.pages.isNotEmpty) return;

    final pages = OnboardL10n.buildPages(context.l10n);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      controller.initPages(pages);
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<OnboardController>();
    if (controller.state.pages.isEmpty) {
      return const Scaffold(
        backgroundColor: AppColors.darkBackground,
        body: SizedBox.shrink(),
      );
    }

    final currentPage = controller.state.pages[controller.state.currentPage];
    final isLocationPage = currentPage.isLocationPage;
    final l10n = context.l10n;

    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              OnboardTopBar(
                showSkip: currentPage.showSkip,
                onSkip: () => controller.skipPressed(context),
              ),
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: PageView.builder(
                  controller: controller.pageController,
                  onPageChanged: controller.onPageChanged,
                  itemCount: controller.state.pages.length,
                  itemBuilder: (context, index) {
                    final page = controller.state.pages[index];
                    if (page.isLocationPage) {
                      return OnboardLocationPage(page: page);
                    }
                    return OnboardCarouselPage(page: page);
                  },
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (!isLocationPage)
                    OnboardPageIndicator(
                      pageCount: controller.carouselPageCount,
                      currentIndex: controller.state.currentPage,
                    ),
                  if (!isLocationPage) SizedBox(height: 24.h),
                  PrimaryButton(
                    label: currentPage.buttonLabel,
                    onPressed: () => controller.continuePressed(context),
                  ),
                  if (isLocationPage) ...[
                    SizedBox(height: 12.h),
                    SecondaryOutlinedButton(
                      label: l10n.onboardNotNow,
                      onPressed: () => controller.notNowPressed(context),
                    ),
                  ],
                  SizedBox(height: 24.h),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
