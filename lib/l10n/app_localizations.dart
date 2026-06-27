import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
  ];

  /// No description provided for @navMap.
  ///
  /// In en, this message translates to:
  /// **'Map'**
  String get navMap;

  /// No description provided for @navExplore.
  ///
  /// In en, this message translates to:
  /// **'Explore'**
  String get navExplore;

  /// No description provided for @navMissions.
  ///
  /// In en, this message translates to:
  /// **'Missions'**
  String get navMissions;

  /// No description provided for @navRank.
  ///
  /// In en, this message translates to:
  /// **'Rank'**
  String get navRank;

  /// No description provided for @navProfile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get navProfile;

  /// No description provided for @authOrContinueWith.
  ///
  /// In en, this message translates to:
  /// **'or continue with'**
  String get authOrContinueWith;

  /// No description provided for @authGoogle.
  ///
  /// In en, this message translates to:
  /// **'Google'**
  String get authGoogle;

  /// No description provided for @authEmailLabel.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get authEmailLabel;

  /// No description provided for @authEmailHint.
  ///
  /// In en, this message translates to:
  /// **'you@gmail.com'**
  String get authEmailHint;

  /// No description provided for @authPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get authPasswordLabel;

  /// No description provided for @authPasswordHint.
  ///
  /// In en, this message translates to:
  /// **'********'**
  String get authPasswordHint;

  /// No description provided for @authNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get authNameLabel;

  /// No description provided for @authNameHint.
  ///
  /// In en, this message translates to:
  /// **'Alex Vidal'**
  String get authNameHint;

  /// No description provided for @authLogIn.
  ///
  /// In en, this message translates to:
  /// **'Log in'**
  String get authLogIn;

  /// No description provided for @authPasswordMustContain.
  ///
  /// In en, this message translates to:
  /// **'Password must contain:'**
  String get authPasswordMustContain;

  /// No description provided for @commonCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get commonCancel;

  /// No description provided for @commonDismiss.
  ///
  /// In en, this message translates to:
  /// **'Dismiss'**
  String get commonDismiss;

  /// No description provided for @commonBack.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get commonBack;

  /// No description provided for @commonCopy.
  ///
  /// In en, this message translates to:
  /// **'Copy'**
  String get commonCopy;

  /// No description provided for @commonDone.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get commonDone;

  /// No description provided for @commonSeeAll.
  ///
  /// In en, this message translates to:
  /// **'See all'**
  String get commonSeeAll;

  /// No description provided for @commonViewAll.
  ///
  /// In en, this message translates to:
  /// **'View all'**
  String get commonViewAll;

  /// No description provided for @commonFollow.
  ///
  /// In en, this message translates to:
  /// **'Follow'**
  String get commonFollow;

  /// No description provided for @commonFollowing.
  ///
  /// In en, this message translates to:
  /// **'Following'**
  String get commonFollowing;

  /// No description provided for @commonBlock.
  ///
  /// In en, this message translates to:
  /// **'Block'**
  String get commonBlock;

  /// No description provided for @commonShowMore.
  ///
  /// In en, this message translates to:
  /// **'Show more'**
  String get commonShowMore;

  /// No description provided for @commonShowLess.
  ///
  /// In en, this message translates to:
  /// **'Show less'**
  String get commonShowLess;

  /// No description provided for @commonProgress.
  ///
  /// In en, this message translates to:
  /// **'Progress'**
  String get commonProgress;

  /// No description provided for @commonDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get commonDelete;

  /// No description provided for @commonContinue.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get commonContinue;

  /// No description provided for @commonLevel.
  ///
  /// In en, this message translates to:
  /// **'Level {level}'**
  String commonLevel(int level);

  /// No description provided for @commonPointsShort.
  ///
  /// In en, this message translates to:
  /// **'+{points} pts'**
  String commonPointsShort(int points);

  /// No description provided for @loginWelcomeTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome back'**
  String get loginWelcomeTitle;

  /// No description provided for @loginWelcomeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Your locals are waiting.'**
  String get loginWelcomeSubtitle;

  /// No description provided for @loginRememberMe.
  ///
  /// In en, this message translates to:
  /// **'Remember me'**
  String get loginRememberMe;

  /// No description provided for @loginForgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get loginForgotPassword;

  /// No description provided for @loginButton.
  ///
  /// In en, this message translates to:
  /// **'Log in'**
  String get loginButton;

  /// No description provided for @loginNewHere.
  ///
  /// In en, this message translates to:
  /// **'New here?'**
  String get loginNewHere;

  /// No description provided for @loginCreateAccount.
  ///
  /// In en, this message translates to:
  /// **'Create account'**
  String get loginCreateAccount;

  /// No description provided for @signupTitle.
  ///
  /// In en, this message translates to:
  /// **'Join locals'**
  String get signupTitle;

  /// No description provided for @signupSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Start collecting authentic places.'**
  String get signupSubtitle;

  /// No description provided for @signupButton.
  ///
  /// In en, this message translates to:
  /// **'Create account'**
  String get signupButton;

  /// No description provided for @signupAlreadyLocal.
  ///
  /// In en, this message translates to:
  /// **'Already a local?'**
  String get signupAlreadyLocal;

  /// No description provided for @otpResetPasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'Reset your password'**
  String get otpResetPasswordTitle;

  /// No description provided for @otpResetPasswordSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Use the same mail that you used to create the account'**
  String get otpResetPasswordSubtitle;

  /// No description provided for @otpHint6Digit.
  ///
  /// In en, this message translates to:
  /// **'We have sent a 6-digit code to your email'**
  String get otpHint6Digit;

  /// No description provided for @otpHint4Digit.
  ///
  /// In en, this message translates to:
  /// **'We have sent a 4-digit code to your email'**
  String get otpHint4Digit;

  /// No description provided for @otpVerifyHeader.
  ///
  /// In en, this message translates to:
  /// **'Verify'**
  String get otpVerifyHeader;

  /// No description provided for @otpVerifyButton.
  ///
  /// In en, this message translates to:
  /// **'Verify OTP'**
  String get otpVerifyButton;

  /// No description provided for @otpDidntReceiveCode.
  ///
  /// In en, this message translates to:
  /// **'Didn\'t receive code?'**
  String get otpDidntReceiveCode;

  /// No description provided for @otpResend.
  ///
  /// In en, this message translates to:
  /// **'Resend'**
  String get otpResend;

  /// No description provided for @otpEmailVerifiedTitle.
  ///
  /// In en, this message translates to:
  /// **'Email Verified'**
  String get otpEmailVerifiedTitle;

  /// No description provided for @otpEmailVerifiedMessage.
  ///
  /// In en, this message translates to:
  /// **'Your email has been verified successfully.'**
  String get otpEmailVerifiedMessage;

  /// No description provided for @requestOtpButton.
  ///
  /// In en, this message translates to:
  /// **'Request OTP'**
  String get requestOtpButton;

  /// No description provided for @setPasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'Create a new password'**
  String get setPasswordTitle;

  /// No description provided for @setPasswordSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Create something unique but rememberable'**
  String get setPasswordSubtitle;

  /// No description provided for @setPasswordNewLabel.
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get setPasswordNewLabel;

  /// No description provided for @setPasswordNewHint.
  ///
  /// In en, this message translates to:
  /// **'Something secure'**
  String get setPasswordNewHint;

  /// No description provided for @setPasswordConfirmLabel.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get setPasswordConfirmLabel;

  /// No description provided for @setPasswordConfirmHint.
  ///
  /// In en, this message translates to:
  /// **'Confirm your password'**
  String get setPasswordConfirmHint;

  /// No description provided for @setPasswordButton.
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get setPasswordButton;

  /// No description provided for @setPasswordBackTo.
  ///
  /// In en, this message translates to:
  /// **'Back to'**
  String get setPasswordBackTo;

  /// No description provided for @setPasswordSuccessTitle.
  ///
  /// In en, this message translates to:
  /// **'Password Changed'**
  String get setPasswordSuccessTitle;

  /// No description provided for @setPasswordSuccessMessage.
  ///
  /// In en, this message translates to:
  /// **'Your password has been changed successfully.'**
  String get setPasswordSuccessMessage;

  /// No description provided for @passwordReqMinLength.
  ///
  /// In en, this message translates to:
  /// **'At least 8 characters'**
  String get passwordReqMinLength;

  /// No description provided for @passwordReqUppercase.
  ///
  /// In en, this message translates to:
  /// **'Contains uppercase letter'**
  String get passwordReqUppercase;

  /// No description provided for @passwordReqLowercase.
  ///
  /// In en, this message translates to:
  /// **'Contains lowercase letter'**
  String get passwordReqLowercase;

  /// No description provided for @passwordReqNumber.
  ///
  /// In en, this message translates to:
  /// **'Contains number'**
  String get passwordReqNumber;

  /// No description provided for @dialogLogoutTitle.
  ///
  /// In en, this message translates to:
  /// **'Log out?'**
  String get dialogLogoutTitle;

  /// No description provided for @dialogLogoutMessage.
  ///
  /// In en, this message translates to:
  /// **'You will need to sign in again to access your profile, missions, and saved places.'**
  String get dialogLogoutMessage;

  /// No description provided for @dialogLogoutConfirm.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get dialogLogoutConfirm;

  /// No description provided for @dialogDeleteAccountTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete account?'**
  String get dialogDeleteAccountTitle;

  /// No description provided for @dialogDeleteAccountMessage.
  ///
  /// In en, this message translates to:
  /// **'This permanently removes your profile, progress, and saved data. This action cannot be undone.'**
  String get dialogDeleteAccountMessage;

  /// No description provided for @dialogDeleteAccountConfirm.
  ///
  /// In en, this message translates to:
  /// **'Delete account'**
  String get dialogDeleteAccountConfirm;

  /// No description provided for @legalLastUpdated.
  ///
  /// In en, this message translates to:
  /// **'Last updated: {date}'**
  String legalLastUpdated(String date);

  /// No description provided for @onboardSkip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get onboardSkip;

  /// No description provided for @onboardNotNow.
  ///
  /// In en, this message translates to:
  /// **'Not now'**
  String get onboardNotNow;

  /// No description provided for @onboardPage1Title.
  ///
  /// In en, this message translates to:
  /// **'Discover authentic local places'**
  String get onboardPage1Title;

  /// No description provided for @onboardPage1Subtitle.
  ///
  /// In en, this message translates to:
  /// **'Hand-picked spots with the locals\' seal — the ones neighbors actually love.'**
  String get onboardPage1Subtitle;

  /// No description provided for @onboardPage2Title.
  ///
  /// In en, this message translates to:
  /// **'Collect locations, earn points'**
  String get onboardPage2Title;

  /// No description provided for @onboardPage2Subtitle.
  ///
  /// In en, this message translates to:
  /// **'Check in when you visit. Every authentic place becomes part of your map.'**
  String get onboardPage2Subtitle;

  /// No description provided for @onboardPage3Title.
  ///
  /// In en, this message translates to:
  /// **'Level up, complete cities'**
  String get onboardPage3Title;

  /// No description provided for @onboardPage3Subtitle.
  ///
  /// In en, this message translates to:
  /// **'Climb the ranks, unlock achievements, and chase 100% completion.'**
  String get onboardPage3Subtitle;

  /// No description provided for @onboardPage4Title.
  ///
  /// In en, this message translates to:
  /// **'Find locals around you'**
  String get onboardPage4Title;

  /// No description provided for @onboardPage4Subtitle.
  ///
  /// In en, this message translates to:
  /// **'We use your location to show authentic places nearby and to confirm your check-ins. Your location is never shared with other users.'**
  String get onboardPage4Subtitle;

  /// No description provided for @onboardContinue.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get onboardContinue;

  /// No description provided for @onboardGetStarted.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get onboardGetStarted;

  /// No description provided for @onboardAllowLocation.
  ///
  /// In en, this message translates to:
  /// **'Allow location'**
  String get onboardAllowLocation;

  /// No description provided for @exploreNewLocals.
  ///
  /// In en, this message translates to:
  /// **'NEW LOCALS'**
  String get exploreNewLocals;

  /// No description provided for @localShares.
  ///
  /// In en, this message translates to:
  /// **'LOCAL SHARES'**
  String get localShares;

  /// No description provided for @exploreFeaturedLocations.
  ///
  /// In en, this message translates to:
  /// **'FEATURED LOCATIONS'**
  String get exploreFeaturedLocations;

  /// No description provided for @exploreFeaturedRoutes.
  ///
  /// In en, this message translates to:
  /// **'FEATURED ROUTES'**
  String get exploreFeaturedRoutes;

  /// No description provided for @exploreFindLocalsToFollow.
  ///
  /// In en, this message translates to:
  /// **'FIND LOCALS TO FOLLOW'**
  String get exploreFindLocalsToFollow;

  /// No description provided for @exploreRecentActivity.
  ///
  /// In en, this message translates to:
  /// **'RECENT ACTIVITY'**
  String get exploreRecentActivity;

  /// No description provided for @exploreWeeklyRanking.
  ///
  /// In en, this message translates to:
  /// **'WEEKLY RANKING'**
  String get exploreWeeklyRanking;

  /// No description provided for @exploreAllEvents.
  ///
  /// In en, this message translates to:
  /// **'All events'**
  String get exploreAllEvents;

  /// No description provided for @exploreNewCategory.
  ///
  /// In en, this message translates to:
  /// **'NEW · {category}'**
  String exploreNewCategory(String category);

  /// No description provided for @exploreYourStory.
  ///
  /// In en, this message translates to:
  /// **'Your story'**
  String get exploreYourStory;

  /// No description provided for @exploreViewYourStory.
  ///
  /// In en, this message translates to:
  /// **'View your story'**
  String get exploreViewYourStory;

  /// No description provided for @exploreAddPhoto.
  ///
  /// In en, this message translates to:
  /// **'Add photo'**
  String get exploreAddPhoto;

  /// No description provided for @findLocalsTitle.
  ///
  /// In en, this message translates to:
  /// **'Find Locals'**
  String get findLocalsTitle;

  /// No description provided for @featuredLocationsTitle.
  ///
  /// In en, this message translates to:
  /// **'Featured locations'**
  String get featuredLocationsTitle;

  /// No description provided for @eventsRoutesTitle.
  ///
  /// In en, this message translates to:
  /// **'Events & routes'**
  String get eventsRoutesTitle;

  /// No description provided for @eventsByOrganizer.
  ///
  /// In en, this message translates to:
  /// **'By {organizer}'**
  String eventsByOrganizer(String organizer);

  /// No description provided for @eventSponsoredBy.
  ///
  /// In en, this message translates to:
  /// **'Sponsored · {sponsor}'**
  String eventSponsoredBy(String sponsor);

  /// No description provided for @joinEventRouteStops.
  ///
  /// In en, this message translates to:
  /// **'ROUTE STOPS'**
  String get joinEventRouteStops;

  /// No description provided for @joinEventButton.
  ///
  /// In en, this message translates to:
  /// **'Join event'**
  String get joinEventButton;

  /// No description provided for @joinEventJoined.
  ///
  /// In en, this message translates to:
  /// **'Joined'**
  String get joinEventJoined;

  /// No description provided for @eventCheckInNextStop.
  ///
  /// In en, this message translates to:
  /// **'Check in next stop'**
  String get eventCheckInNextStop;

  /// No description provided for @eventRouteComplete.
  ///
  /// In en, this message translates to:
  /// **'Route complete'**
  String get eventRouteComplete;

  /// No description provided for @sponsored.
  ///
  /// In en, this message translates to:
  /// **'Sponsored'**
  String get sponsored;

  /// No description provided for @learnMore.
  ///
  /// In en, this message translates to:
  /// **'Learn More'**
  String get learnMore;

  /// No description provided for @restaurantLocalsSeal.
  ///
  /// In en, this message translates to:
  /// **'locals\' seal'**
  String get restaurantLocalsSeal;

  /// No description provided for @authConfirmPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get authConfirmPasswordLabel;

  /// No description provided for @restaurantLocalSpot.
  ///
  /// In en, this message translates to:
  /// **'Local spot'**
  String get restaurantLocalSpot;

  /// No description provided for @authConfirmPasswordHint.
  ///
  /// In en, this message translates to:
  /// **'********'**
  String get authConfirmPasswordHint;

  /// No description provided for @restaurantBeenHere.
  ///
  /// In en, this message translates to:
  /// **'I\'ve been here'**
  String get restaurantBeenHere;

  /// No description provided for @restaurantBeenHereDone.
  ///
  /// In en, this message translates to:
  /// **'I\'ve been here ✓'**
  String get restaurantBeenHereDone;

  /// No description provided for @restaurantDirections.
  ///
  /// In en, this message translates to:
  /// **'Directions'**
  String get restaurantDirections;

  /// No description provided for @restaurantPhotos.
  ///
  /// In en, this message translates to:
  /// **'Photos'**
  String get restaurantPhotos;

  /// No description provided for @profileDetails.
  ///
  /// In en, this message translates to:
  /// **'Profile Details'**
  String get profileDetails;

  /// No description provided for @busniessOfTheMonth.
  ///
  /// In en, this message translates to:
  /// **'Business of the month'**
  String get busniessOfTheMonth;

  /// No description provided for @restaurantVisitors.
  ///
  /// In en, this message translates to:
  /// **'Visitors'**
  String get restaurantVisitors;

  /// No description provided for @shareLocationTitle.
  ///
  /// In en, this message translates to:
  /// **'Share the location'**
  String get shareLocationTitle;

  /// No description provided for @storyDeleteTooltip.
  ///
  /// In en, this message translates to:
  /// **'Delete this story'**
  String get storyDeleteTooltip;

  /// No description provided for @storyViewersTitle.
  ///
  /// In en, this message translates to:
  /// **'Viewers'**
  String get storyViewersTitle;

  /// No description provided for @storyViewersEmpty.
  ///
  /// In en, this message translates to:
  /// **'No one has viewed this story yet.'**
  String get storyViewersEmpty;

  /// No description provided for @storyDeletePhotoTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete this photo?'**
  String get storyDeletePhotoTitle;

  /// No description provided for @storyDeletePhotoMessage.
  ///
  /// In en, this message translates to:
  /// **'Only this story slide will be removed. Your other stories stay.'**
  String get storyDeletePhotoMessage;

  /// No description provided for @checkInConfirmed.
  ///
  /// In en, this message translates to:
  /// **'CHECK-IN CONFIRMED'**
  String get checkInConfirmed;

  /// No description provided for @checkInLocationYours.
  ///
  /// In en, this message translates to:
  /// **'{locationName} is yours.'**
  String checkInLocationYours(String locationName);

  /// No description provided for @checkInAddedToMap.
  ///
  /// In en, this message translates to:
  /// **'Another local added to your map.'**
  String get checkInAddedToMap;

  /// No description provided for @checkInShareMoment.
  ///
  /// In en, this message translates to:
  /// **'Share moment'**
  String get checkInShareMoment;

  /// No description provided for @checkInContinueExploring.
  ///
  /// In en, this message translates to:
  /// **'Continue exploring'**
  String get checkInContinueExploring;

  /// No description provided for @shareCardTitle.
  ///
  /// In en, this message translates to:
  /// **'Share card'**
  String get shareCardTitle;

  /// No description provided for @shareCardTapToCapture.
  ///
  /// In en, this message translates to:
  /// **'Tap to capture'**
  String get shareCardTapToCapture;

  /// No description provided for @shareCardRetake.
  ///
  /// In en, this message translates to:
  /// **'Retake'**
  String get shareCardRetake;

  /// No description provided for @shareCardConfirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get shareCardConfirm;

  /// No description provided for @shareCardAddToStory.
  ///
  /// In en, this message translates to:
  /// **'Add to Story'**
  String get shareCardAddToStory;

  /// No description provided for @shareCardSaving.
  ///
  /// In en, this message translates to:
  /// **'Saving...'**
  String get shareCardSaving;

  /// No description provided for @shareCardSaved.
  ///
  /// In en, this message translates to:
  /// **'Saved'**
  String get shareCardSaved;

  /// No description provided for @shareCardSaveImage.
  ///
  /// In en, this message translates to:
  /// **'Save Image'**
  String get shareCardSaveImage;

  /// No description provided for @shareProfileTitle.
  ///
  /// In en, this message translates to:
  /// **'Share your profile'**
  String get shareProfileTitle;

  /// No description provided for @statVisits.
  ///
  /// In en, this message translates to:
  /// **'VISITS'**
  String get statVisits;

  /// No description provided for @statCities.
  ///
  /// In en, this message translates to:
  /// **'CITIES'**
  String get statCities;

  /// No description provided for @statFollowers.
  ///
  /// In en, this message translates to:
  /// **'FOLLOWERS'**
  String get statFollowers;

  /// No description provided for @statPoints.
  ///
  /// In en, this message translates to:
  /// **'POINTS'**
  String get statPoints;

  /// No description provided for @statStops.
  ///
  /// In en, this message translates to:
  /// **'STOPS'**
  String get statStops;

  /// No description provided for @statReward.
  ///
  /// In en, this message translates to:
  /// **'REWARD'**
  String get statReward;

  /// No description provided for @statProgress.
  ///
  /// In en, this message translates to:
  /// **'PROGRESS'**
  String get statProgress;

  /// No description provided for @statLevel.
  ///
  /// In en, this message translates to:
  /// **'LEVEL'**
  String get statLevel;

  /// No description provided for @statCity.
  ///
  /// In en, this message translates to:
  /// **'CITY'**
  String get statCity;

  /// No description provided for @mapSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search locals & places'**
  String get mapSearchHint;

  /// No description provided for @mapSearchRecent.
  ///
  /// In en, this message translates to:
  /// **'RECENT'**
  String get mapSearchRecent;

  /// No description provided for @mapSearchTrending.
  ///
  /// In en, this message translates to:
  /// **'TRENDING'**
  String get mapSearchTrending;

  /// No description provided for @filtersTitle.
  ///
  /// In en, this message translates to:
  /// **'Filters'**
  String get filtersTitle;

  /// No description provided for @filtersReset.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get filtersReset;

  /// No description provided for @filtersType.
  ///
  /// In en, this message translates to:
  /// **'TYPE'**
  String get filtersType;

  /// No description provided for @filtersStatus.
  ///
  /// In en, this message translates to:
  /// **'STATUS'**
  String get filtersStatus;

  /// No description provided for @filtersCategories.
  ///
  /// In en, this message translates to:
  /// **'CATEGORIES'**
  String get filtersCategories;

  /// No description provided for @filtersBusinesses.
  ///
  /// In en, this message translates to:
  /// **'Businesses'**
  String get filtersBusinesses;

  /// No description provided for @filtersHerbs.
  ///
  /// In en, this message translates to:
  /// **'Herbs'**
  String get filtersHerbs;

  /// No description provided for @filtersBoth.
  ///
  /// In en, this message translates to:
  /// **'Both'**
  String get filtersBoth;

  /// No description provided for @filtersVisited.
  ///
  /// In en, this message translates to:
  /// **'Visited'**
  String get filtersVisited;

  /// No description provided for @filtersUnvisited.
  ///
  /// In en, this message translates to:
  /// **'Unvisited'**
  String get filtersUnvisited;

  /// No description provided for @filtersApply.
  ///
  /// In en, this message translates to:
  /// **'Apply filters'**
  String get filtersApply;

  /// No description provided for @mapExploring.
  ///
  /// In en, this message translates to:
  /// **'EXPLORING'**
  String get mapExploring;

  /// No description provided for @mapCompletion.
  ///
  /// In en, this message translates to:
  /// **'COMPLETION'**
  String get mapCompletion;

  /// No description provided for @notificationsTitle.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notificationsTitle;

  /// No description provided for @achievementsTitle.
  ///
  /// In en, this message translates to:
  /// **'Achievements'**
  String get achievementsTitle;

  /// No description provided for @missionsTitle.
  ///
  /// In en, this message translates to:
  /// **'Missions'**
  String get missionsTitle;

  /// No description provided for @missionsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Curated challenges to discover Barcelona.'**
  String get missionsSubtitle;

  /// No description provided for @missionFilterNearby.
  ///
  /// In en, this message translates to:
  /// **'Nearby'**
  String get missionFilterNearby;

  /// No description provided for @missionFilterActive.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get missionFilterActive;

  /// No description provided for @missionFilterCompleted.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get missionFilterCompleted;

  /// No description provided for @missionFilterEvents.
  ///
  /// In en, this message translates to:
  /// **'Events'**
  String get missionFilterEvents;

  /// No description provided for @missionStopsSection.
  ///
  /// In en, this message translates to:
  /// **'STOPS'**
  String get missionStopsSection;

  /// No description provided for @missionContinue.
  ///
  /// In en, this message translates to:
  /// **'Continue mission'**
  String get missionContinue;

  /// No description provided for @achievementsUnlocked.
  ///
  /// In en, this message translates to:
  /// **'UNLOCKED'**
  String get achievementsUnlocked;

  /// No description provided for @achievementsKeepVisiting.
  ///
  /// In en, this message translates to:
  /// **'Keep visiting to unlock more.'**
  String get achievementsKeepVisiting;

  /// No description provided for @rankLeaderboardTitle.
  ///
  /// In en, this message translates to:
  /// **'Leaderboard'**
  String get rankLeaderboardTitle;

  /// No description provided for @rankScopeCity.
  ///
  /// In en, this message translates to:
  /// **'City'**
  String get rankScopeCity;

  /// No description provided for @rankScopeCountry.
  ///
  /// In en, this message translates to:
  /// **'Country'**
  String get rankScopeCountry;

  /// No description provided for @rankScopeGlobal.
  ///
  /// In en, this message translates to:
  /// **'Global'**
  String get rankScopeGlobal;

  /// No description provided for @rankScopeFollowers.
  ///
  /// In en, this message translates to:
  /// **'Followers'**
  String get rankScopeFollowers;

  /// No description provided for @rankPeriodWeekly.
  ///
  /// In en, this message translates to:
  /// **'Weekly'**
  String get rankPeriodWeekly;

  /// No description provided for @rankPeriodMonthly.
  ///
  /// In en, this message translates to:
  /// **'Monthly'**
  String get rankPeriodMonthly;

  /// No description provided for @rankPeriodAllTime.
  ///
  /// In en, this message translates to:
  /// **'All-time'**
  String get rankPeriodAllTime;

  /// No description provided for @viewProfileTitle.
  ///
  /// In en, this message translates to:
  /// **'{name}\'s profile'**
  String viewProfileTitle(String name);

  /// No description provided for @viewProfileTabPhotos.
  ///
  /// In en, this message translates to:
  /// **'Photos'**
  String get viewProfileTabPhotos;

  /// No description provided for @viewProfileTabMap.
  ///
  /// In en, this message translates to:
  /// **'Map'**
  String get viewProfileTabMap;

  /// No description provided for @viewProfileTabAchievements.
  ///
  /// In en, this message translates to:
  /// **'Achievements'**
  String get viewProfileTabAchievements;

  /// No description provided for @viewProfileLevelLocation.
  ///
  /// In en, this message translates to:
  /// **'Level {level} · {location}'**
  String viewProfileLevelLocation(int level, String location);

  /// No description provided for @blockUserTitle.
  ///
  /// In en, this message translates to:
  /// **'Block user'**
  String get blockUserTitle;

  /// No description provided for @blockUserMessage.
  ///
  /// In en, this message translates to:
  /// **'Block {name}? They will not be able to see your profile.'**
  String blockUserMessage(String name);

  /// No description provided for @blockUserConfirm.
  ///
  /// In en, this message translates to:
  /// **'Block'**
  String get blockUserConfirm;

  /// No description provided for @profilePointsToNextLevel.
  ///
  /// In en, this message translates to:
  /// **'{points} Pts To Level {nextLevel}'**
  String profilePointsToNextLevel(int points, int nextLevel);

  /// No description provided for @profileMyMap.
  ///
  /// In en, this message translates to:
  /// **'My Map'**
  String get profileMyMap;

  /// No description provided for @profileFollowers.
  ///
  /// In en, this message translates to:
  /// **'Followers'**
  String get profileFollowers;

  /// No description provided for @profileSavedPlace.
  ///
  /// In en, this message translates to:
  /// **'Saved place'**
  String get profileSavedPlace;

  /// No description provided for @profileBlocked.
  ///
  /// In en, this message translates to:
  /// **'Blocked'**
  String get profileBlocked;

  /// No description provided for @profileRecentAchievements.
  ///
  /// In en, this message translates to:
  /// **'Recent achievements'**
  String get profileRecentAchievements;

  /// No description provided for @profileLatestVisits.
  ///
  /// In en, this message translates to:
  /// **'Latest visits'**
  String get profileLatestVisits;

  /// No description provided for @editProfileTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit profile'**
  String get editProfileTitle;

  /// No description provided for @editProfileName.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get editProfileName;

  /// No description provided for @editProfileLocation.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get editProfileLocation;

  /// No description provided for @editProfileSaveChanges.
  ///
  /// In en, this message translates to:
  /// **'Save changes'**
  String get editProfileSaveChanges;

  /// No description provided for @editProfileChangePassword.
  ///
  /// In en, this message translates to:
  /// **'Change password'**
  String get editProfileChangePassword;

  /// No description provided for @editProfileCurrentPassword.
  ///
  /// In en, this message translates to:
  /// **'Current password'**
  String get editProfileCurrentPassword;

  /// No description provided for @editProfileNewPassword.
  ///
  /// In en, this message translates to:
  /// **'New password'**
  String get editProfileNewPassword;

  /// No description provided for @editProfileConfirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm password'**
  String get editProfileConfirmPassword;

  /// No description provided for @myMapTitle.
  ///
  /// In en, this message translates to:
  /// **'My map'**
  String get myMapTitle;

  /// No description provided for @myMapFilterAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get myMapFilterAll;

  /// No description provided for @myMapFilterVisited.
  ///
  /// In en, this message translates to:
  /// **'Visited · {count}'**
  String myMapFilterVisited(int count);

  /// No description provided for @myMapFilterUnvisited.
  ///
  /// In en, this message translates to:
  /// **'Unvisited · {count}'**
  String myMapFilterUnvisited(int count);

  /// No description provided for @myMapLegendVisited.
  ///
  /// In en, this message translates to:
  /// **'Visited'**
  String get myMapLegendVisited;

  /// No description provided for @myMapLegendUnvisited.
  ///
  /// In en, this message translates to:
  /// **'Unvisited'**
  String get myMapLegendUnvisited;

  /// No description provided for @listTitle.
  ///
  /// In en, this message translates to:
  /// **'List'**
  String get listTitle;

  /// No description provided for @listFollowersCount.
  ///
  /// In en, this message translates to:
  /// **'Followers · {count}'**
  String listFollowersCount(int count);

  /// No description provided for @listFollowingCount.
  ///
  /// In en, this message translates to:
  /// **'Following · {count}'**
  String listFollowingCount(int count);

  /// No description provided for @listLevelFollowsYou.
  ///
  /// In en, this message translates to:
  /// **'Level {level} · Follows you'**
  String listLevelFollowsYou(int level);

  /// No description provided for @blockedListTitle.
  ///
  /// In en, this message translates to:
  /// **'Blocked list'**
  String get blockedListTitle;

  /// No description provided for @blockedUnblock.
  ///
  /// In en, this message translates to:
  /// **'Unblock'**
  String get blockedUnblock;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @settingsSectionPreferences.
  ///
  /// In en, this message translates to:
  /// **'PREFERENCES'**
  String get settingsSectionPreferences;

  /// No description provided for @settingsSectionAccount.
  ///
  /// In en, this message translates to:
  /// **'ACCOUNT'**
  String get settingsSectionAccount;

  /// No description provided for @settingsSectionAbout.
  ///
  /// In en, this message translates to:
  /// **'ABOUT'**
  String get settingsSectionAbout;

  /// No description provided for @settingsSectionDangerZone.
  ///
  /// In en, this message translates to:
  /// **'DANGER ZONE'**
  String get settingsSectionDangerZone;

  /// No description provided for @settingsLanguage.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settingsLanguage;

  /// No description provided for @settingsNotification.
  ///
  /// In en, this message translates to:
  /// **'Notification'**
  String get settingsNotification;

  /// No description provided for @settingsPrivacy.
  ///
  /// In en, this message translates to:
  /// **'Privacy'**
  String get settingsPrivacy;

  /// No description provided for @settingsEditProfile.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get settingsEditProfile;

  /// No description provided for @settingsHelpSupport.
  ///
  /// In en, this message translates to:
  /// **'Help & Support'**
  String get settingsHelpSupport;

  /// No description provided for @settingsPrivacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy and policy'**
  String get settingsPrivacyPolicy;

  /// No description provided for @settingsRateLocal.
  ///
  /// In en, this message translates to:
  /// **'Rate Local'**
  String get settingsRateLocal;

  /// No description provided for @settingsLogOut.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get settingsLogOut;

  /// No description provided for @languageEnglish.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageEnglish;

  /// No description provided for @languageSpanish.
  ///
  /// In en, this message translates to:
  /// **'Spanish'**
  String get languageSpanish;

  /// No description provided for @languagePickerTitle.
  ///
  /// In en, this message translates to:
  /// **'Choose language'**
  String get languagePickerTitle;

  /// No description provided for @privacyTitle.
  ///
  /// In en, this message translates to:
  /// **'Privacy'**
  String get privacyTitle;

  /// No description provided for @privacySectionProfileVisibility.
  ///
  /// In en, this message translates to:
  /// **'PROFILE VISIBILITY'**
  String get privacySectionProfileVisibility;

  /// No description provided for @privacySectionPhotoVisibility.
  ///
  /// In en, this message translates to:
  /// **'PHOTO VISIBILITY'**
  String get privacySectionPhotoVisibility;

  /// No description provided for @privacySectionLocationPermission.
  ///
  /// In en, this message translates to:
  /// **'LOCATION PERMISSION'**
  String get privacySectionLocationPermission;

  /// No description provided for @privacySectionLeaderboard.
  ///
  /// In en, this message translates to:
  /// **'SHOW ON LEADERBOARD'**
  String get privacySectionLeaderboard;

  /// No description provided for @privacyPublic.
  ///
  /// In en, this message translates to:
  /// **'Public'**
  String get privacyPublic;

  /// No description provided for @privacyPrivate.
  ///
  /// In en, this message translates to:
  /// **'Private'**
  String get privacyPrivate;

  /// No description provided for @privacyFollowersOnly.
  ///
  /// In en, this message translates to:
  /// **'Followers only'**
  String get privacyFollowersOnly;

  /// No description provided for @privacyAllTime.
  ///
  /// In en, this message translates to:
  /// **'All time'**
  String get privacyAllTime;

  /// No description provided for @privacyWhileUsingApp.
  ///
  /// In en, this message translates to:
  /// **'While using app'**
  String get privacyWhileUsingApp;

  /// No description provided for @privacyOn.
  ///
  /// In en, this message translates to:
  /// **'On'**
  String get privacyOn;

  /// No description provided for @privacyOff.
  ///
  /// In en, this message translates to:
  /// **'Off'**
  String get privacyOff;

  /// No description provided for @privacyDataTitle.
  ///
  /// In en, this message translates to:
  /// **'Privacy & Data'**
  String get privacyDataTitle;

  /// No description provided for @privacyDeleteAccount.
  ///
  /// In en, this message translates to:
  /// **'Delete my account'**
  String get privacyDeleteAccount;

  /// No description provided for @privacyPolicyLink.
  ///
  /// In en, this message translates to:
  /// **'Privacy policy'**
  String get privacyPolicyLink;

  /// No description provided for @termsOfUseLink.
  ///
  /// In en, this message translates to:
  /// **'Terms of use'**
  String get termsOfUseLink;

  /// No description provided for @termsOfUseTitle.
  ///
  /// In en, this message translates to:
  /// **'Terms of use'**
  String get termsOfUseTitle;

  /// No description provided for @privacyPolicyTitle.
  ///
  /// In en, this message translates to:
  /// **'Privacy policy'**
  String get privacyPolicyTitle;

  /// No description provided for @privacyDataEncryptedTitle.
  ///
  /// In en, this message translates to:
  /// **'Your data is encrypted'**
  String get privacyDataEncryptedTitle;

  /// No description provided for @privacyDataEncryptedSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Health information is stored locally and synced securely.'**
  String get privacyDataEncryptedSubtitle;

  /// No description provided for @notificationMissionAlerts.
  ///
  /// In en, this message translates to:
  /// **'Mission alerts'**
  String get notificationMissionAlerts;

  /// No description provided for @notificationMissionAlertsDesc.
  ///
  /// In en, this message translates to:
  /// **'When a new mission is available.'**
  String get notificationMissionAlertsDesc;

  /// No description provided for @notificationEvents.
  ///
  /// In en, this message translates to:
  /// **'Events'**
  String get notificationEvents;

  /// No description provided for @notificationEventsDesc.
  ///
  /// In en, this message translates to:
  /// **'Festivals and sponsored routes.'**
  String get notificationEventsDesc;

  /// No description provided for @notificationAnnouncements.
  ///
  /// In en, this message translates to:
  /// **'Announcements'**
  String get notificationAnnouncements;

  /// No description provided for @notificationAnnouncementsDesc.
  ///
  /// In en, this message translates to:
  /// **'Festivals and sponsored routes.'**
  String get notificationAnnouncementsDesc;

  /// No description provided for @helpSupportTitle.
  ///
  /// In en, this message translates to:
  /// **'Help & Support'**
  String get helpSupportTitle;

  /// No description provided for @helpSubjectLabel.
  ///
  /// In en, this message translates to:
  /// **'Subject'**
  String get helpSubjectLabel;

  /// No description provided for @helpMessageLabel.
  ///
  /// In en, this message translates to:
  /// **'Message'**
  String get helpMessageLabel;

  /// No description provided for @helpMessageHint.
  ///
  /// In en, this message translates to:
  /// **'Describe your issue or question...'**
  String get helpMessageHint;

  /// No description provided for @helpSending.
  ///
  /// In en, this message translates to:
  /// **'Sending...'**
  String get helpSending;

  /// No description provided for @helpSend.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get helpSend;

  /// No description provided for @helpVersion.
  ///
  /// In en, this message translates to:
  /// **'Version {version}'**
  String helpVersion(String version);

  /// No description provided for @helpEmailTo.
  ///
  /// In en, this message translates to:
  /// **'To'**
  String get helpEmailTo;

  /// No description provided for @subscriptionTitle.
  ///
  /// In en, this message translates to:
  /// **'Manage Subscription'**
  String get subscriptionTitle;

  /// No description provided for @subscriptionCurrentPlan.
  ///
  /// In en, this message translates to:
  /// **'Current plan'**
  String get subscriptionCurrentPlan;

  /// No description provided for @subscriptionPremiumUnlocked.
  ///
  /// In en, this message translates to:
  /// **'All premium features unlocked'**
  String get subscriptionPremiumUnlocked;

  /// No description provided for @subscriptionBillingHistory.
  ///
  /// In en, this message translates to:
  /// **'BILLING HISTORY'**
  String get subscriptionBillingHistory;

  /// No description provided for @subscriptionUpdatePayment.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get subscriptionUpdatePayment;

  /// No description provided for @subscriptionAutoRenew.
  ///
  /// In en, this message translates to:
  /// **'Auto-renew'**
  String get subscriptionAutoRenew;

  /// No description provided for @subscriptionAutoRenewDesc.
  ///
  /// In en, this message translates to:
  /// **'Will renew automatically each month'**
  String get subscriptionAutoRenewDesc;

  /// No description provided for @subscriptionUpgradeYearly.
  ///
  /// In en, this message translates to:
  /// **'Upgrade to Yearly'**
  String get subscriptionUpgradeYearly;

  /// No description provided for @subscriptionYearlySavings.
  ///
  /// In en, this message translates to:
  /// **'Save 50% · \$4.92/mo'**
  String get subscriptionYearlySavings;

  /// No description provided for @subscriptionSwitch.
  ///
  /// In en, this message translates to:
  /// **'Switch'**
  String get subscriptionSwitch;

  /// No description provided for @subscriptionCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel subscription'**
  String get subscriptionCancel;

  /// No description provided for @filterCategoryRestaurant.
  ///
  /// In en, this message translates to:
  /// **'Restaurant'**
  String get filterCategoryRestaurant;

  /// No description provided for @filterCategoryBar.
  ///
  /// In en, this message translates to:
  /// **'Bar'**
  String get filterCategoryBar;

  /// No description provided for @filterCategoryCafe.
  ///
  /// In en, this message translates to:
  /// **'Cafe'**
  String get filterCategoryCafe;

  /// No description provided for @filterCategoryBakery.
  ///
  /// In en, this message translates to:
  /// **'Bakery'**
  String get filterCategoryBakery;

  /// No description provided for @filterCategoryShop.
  ///
  /// In en, this message translates to:
  /// **'Shop'**
  String get filterCategoryShop;

  /// No description provided for @filterCategoryMarket.
  ///
  /// In en, this message translates to:
  /// **'Market'**
  String get filterCategoryMarket;

  /// No description provided for @filterCategoryMonument.
  ///
  /// In en, this message translates to:
  /// **'Monument'**
  String get filterCategoryMonument;

  /// No description provided for @filterCategoryCultural.
  ///
  /// In en, this message translates to:
  /// **'Cultural Space'**
  String get filterCategoryCultural;

  /// No description provided for @filterCategoryViewpoint.
  ///
  /// In en, this message translates to:
  /// **'Viewpoint'**
  String get filterCategoryViewpoint;

  /// No description provided for @filterCategorySquare.
  ///
  /// In en, this message translates to:
  /// **'Square'**
  String get filterCategorySquare;

  /// No description provided for @filterCategoryOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get filterCategoryOther;

  /// No description provided for @snackbarLinkCopied.
  ///
  /// In en, this message translates to:
  /// **'Link copied'**
  String get snackbarLinkCopied;

  /// No description provided for @snackbarCaptureFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to capture photo'**
  String get snackbarCaptureFailed;

  /// No description provided for @snackbarThanksFeedback.
  ///
  /// In en, this message translates to:
  /// **'Thanks for your feedback!'**
  String get snackbarThanksFeedback;

  /// No description provided for @snackbarProfileUpdated.
  ///
  /// In en, this message translates to:
  /// **'Profile updated'**
  String get snackbarProfileUpdated;

  /// No description provided for @snackbarPasswordsNoMatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get snackbarPasswordsNoMatch;

  /// No description provided for @snackbarPasswordChanged.
  ///
  /// In en, this message translates to:
  /// **'Password changed'**
  String get snackbarPasswordChanged;

  /// No description provided for @snackbarPasswordChangeFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not change password'**
  String get snackbarPasswordChangeFailed;

  /// No description provided for @snackbarStoryAdded.
  ///
  /// In en, this message translates to:
  /// **'Story added'**
  String get snackbarStoryAdded;

  /// No description provided for @photoLikesCount.
  ///
  /// In en, this message translates to:
  /// **'{count} likes'**
  String photoLikesCount(int count);

  /// No description provided for @savedPlacesTitle.
  ///
  /// In en, this message translates to:
  /// **'Saved places'**
  String get savedPlacesTitle;

  /// No description provided for @storyJustNow.
  ///
  /// In en, this message translates to:
  /// **'Just now'**
  String get storyJustNow;

  /// No description provided for @snackbarCapturePhotoFirst.
  ///
  /// In en, this message translates to:
  /// **'Capture a photo first'**
  String get snackbarCapturePhotoFirst;

  /// No description provided for @helpWriteMessage.
  ///
  /// In en, this message translates to:
  /// **'Please write a message'**
  String get helpWriteMessage;

  /// No description provided for @helpOpeningEmail.
  ///
  /// In en, this message translates to:
  /// **'Opening email app'**
  String get helpOpeningEmail;

  /// No description provided for @helpCouldNotOpenEmail.
  ///
  /// In en, this message translates to:
  /// **'Could not open email app'**
  String get helpCouldNotOpenEmail;

  /// No description provided for @cameraNoAvailable.
  ///
  /// In en, this message translates to:
  /// **'No camera available on this device.'**
  String get cameraNoAvailable;

  /// No description provided for @cameraCouldNotOpen.
  ///
  /// In en, this message translates to:
  /// **'Could not open the camera. Please try again.'**
  String get cameraCouldNotOpen;

  /// No description provided for @shareCardTakePhoto.
  ///
  /// In en, this message translates to:
  /// **'Take photo'**
  String get shareCardTakePhoto;

  /// No description provided for @shareCardChooseGallery.
  ///
  /// In en, this message translates to:
  /// **'Choose from gallery'**
  String get shareCardChooseGallery;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
