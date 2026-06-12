import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:locals/shared/components/onboard_page_indicator.dart';
import 'package:locals/shared/components/primary_button.dart';
import 'package:locals/shared/components/secondary_outlined_button.dart';
import 'package:locals/shared/theme/app_colors.dart';
import '../controller/onboard_controller.dart';
import '../repository/onboard_repository.dart';
import 'widgets/onboard_carousel_page.dart';
import 'widgets/onboard_location_page.dart';
import 'widgets/onboard_top_bar.dart';

class OnboardScreen extends StatelessWidget {
  const OnboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => OnboardController(OnboardRepositoryImpl()),
      child: const _OnboardView(),
    );
  }
}

class _OnboardView extends StatelessWidget {
  const _OnboardView();

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<OnboardController>();
    final currentPage = controller.state.pages[controller.state.currentPage];
    final isLocationPage = currentPage.isLocationPage;

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
                      label: 'Not now',
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
