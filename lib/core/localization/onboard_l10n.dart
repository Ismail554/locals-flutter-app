import 'package:locals/features/onboard/model/onboard_model.dart';
import 'package:locals/l10n/app_localizations.dart';
import 'package:locals/shared/theme/app_assets.dart';

class OnboardL10n {
  OnboardL10n._();

  static List<OnboardPageData> buildPages(AppLocalizations l10n) {
    return [
      OnboardPageData(
        imageAsset: AppAssets.onboardMap1,
        title: l10n.onboardPage1Title,
        subtitle: l10n.onboardPage1Subtitle,
        buttonLabel: l10n.onboardContinue,
      ),
      OnboardPageData(
        imageAsset: AppAssets.onboardMapPin2,
        title: l10n.onboardPage2Title,
        subtitle: l10n.onboardPage2Subtitle,
        buttonLabel: l10n.onboardContinue,
      ),
      OnboardPageData(
        imageAsset: AppAssets.onboardTrophy3,
        title: l10n.onboardPage3Title,
        subtitle: l10n.onboardPage3Subtitle,
        buttonLabel: l10n.onboardGetStarted,
      ),
      OnboardPageData(
        imageAsset: AppAssets.onboardLocation4,
        title: l10n.onboardPage4Title,
        subtitle: l10n.onboardPage4Subtitle,
        buttonLabel: l10n.onboardAllowLocation,
        showSkip: false,
        isLocationPage: true,
      ),
    ];
  }
}
