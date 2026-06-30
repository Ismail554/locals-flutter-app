// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get navMap => 'Map';

  @override
  String get navExplore => 'Explore';

  @override
  String get navMissions => 'Missions';

  @override
  String get navRank => 'Rank';

  @override
  String get navProfile => 'Profile';

  @override
  String get authOrContinueWith => 'or continue with';

  @override
  String get authGoogle => 'Google';

  @override
  String get authEmailLabel => 'Email';

  @override
  String get authEmailHint => 'you@gmail.com';

  @override
  String get authPasswordLabel => 'Password';

  @override
  String get authPasswordHint => '********';

  @override
  String get authNameLabel => 'Name';

  @override
  String get authNameHint => 'Alex Vidal';

  @override
  String get authLogIn => 'Log in';

  @override
  String get authPasswordMustContain => 'Password must contain:';

  @override
  String get commonCancel => 'Cancel';

  @override
  String get commonDismiss => 'Dismiss';

  @override
  String get commonBack => 'Back';

  @override
  String get commonCopy => 'Copy';

  @override
  String get commonDone => 'Done';

  @override
  String get commonSeeAll => 'See all';

  @override
  String get commonViewAll => 'View all';

  @override
  String get commonFollow => 'Follow';

  @override
  String get commonFollowing => 'Following';

  @override
  String get commonBlock => 'Block';

  @override
  String get commonShowMore => 'Show more';

  @override
  String get commonShowLess => 'Show less';

  @override
  String get commonProgress => 'Progress';

  @override
  String get commonDelete => 'Delete';

  @override
  String get commonContinue => 'Continue';

  @override
  String commonLevel(int level) {
    return 'Level $level';
  }

  @override
  String commonPointsShort(int points) {
    return '+$points pts';
  }

  @override
  String get loginWelcomeTitle => 'Welcome back';

  @override
  String get loginWelcomeSubtitle => 'Your locals are waiting.';

  @override
  String get loginRememberMe => 'Remember me';

  @override
  String get loginForgotPassword => 'Forgot password?';

  @override
  String get loginButton => 'Log in';

  @override
  String get loginNewHere => 'New here?';

  @override
  String get loginCreateAccount => 'Create account';

  @override
  String get signupTitle => 'Join locals';

  @override
  String get signupSubtitle => 'Start collecting authentic places.';

  @override
  String get signupButton => 'Create account';

  @override
  String get signupAlreadyLocal => 'Already a local?';

  @override
  String get otpResetPasswordTitle => 'Reset your password';

  @override
  String get otpResetPasswordSubtitle =>
      'Use the same mail that you used to create the account';

  @override
  String get otpHint6Digit => 'We have sent a 6-digit code to your email';

  @override
  String get otpHint4Digit => 'We have sent a 4-digit code to your email';

  @override
  String get otpVerifyHeader => 'Verify';

  @override
  String get otpVerifyButton => 'Verify OTP';

  @override
  String get otpDidntReceiveCode => 'Didn\'t receive code?';

  @override
  String get otpResend => 'Resend';

  @override
  String get otpEmailVerifiedTitle => 'Email Verified';

  @override
  String get otpEmailVerifiedMessage =>
      'Your email has been verified successfully.';

  @override
  String get requestOtpButton => 'Request OTP';

  @override
  String get setPasswordTitle => 'Create a new password';

  @override
  String get setPasswordSubtitle => 'Create something unique but rememberable';

  @override
  String get setPasswordNewLabel => 'New Password';

  @override
  String get setPasswordNewHint => 'Something secure';

  @override
  String get setPasswordConfirmLabel => 'Confirm Password';

  @override
  String get setPasswordConfirmHint => 'Confirm your password';

  @override
  String get setPasswordButton => 'Reset Password';

  @override
  String get setPasswordBackTo => 'Back to';

  @override
  String get setPasswordSuccessTitle => 'Password Changed';

  @override
  String get setPasswordSuccessMessage =>
      'Your password has been changed successfully.';

  @override
  String get passwordReqMinLength => 'At least 8 characters';

  @override
  String get passwordReqUppercase => 'Contains uppercase letter';

  @override
  String get passwordReqLowercase => 'Contains lowercase letter';

  @override
  String get passwordReqNumber => 'Contains number';

  @override
  String get dialogLogoutTitle => 'Log out?';

  @override
  String get dialogLogoutMessage =>
      'You will need to sign in again to access your profile, missions, and saved places.';

  @override
  String get dialogLogoutConfirm => 'Log out';

  @override
  String get dialogDeleteAccountTitle => 'Delete account?';

  @override
  String get dialogDeleteAccountMessage =>
      'This permanently removes your profile, progress, and saved data. This action cannot be undone.';

  @override
  String get dialogDeleteAccountConfirm => 'Delete account';

  @override
  String legalLastUpdated(String date) {
    return 'Last updated: $date';
  }

  @override
  String get onboardSkip => 'Skip';

  @override
  String get onboardNotNow => 'Not now';

  @override
  String get onboardPage1Title => 'Discover authentic local places';

  @override
  String get onboardPage1Subtitle =>
      'Hand-picked spots with the locals\' seal — the ones neighbors actually love.';

  @override
  String get onboardPage2Title => 'Collect locations, earn points';

  @override
  String get onboardPage2Subtitle =>
      'Check in when you visit. Every authentic place becomes part of your map.';

  @override
  String get onboardPage3Title => 'Level up, complete cities';

  @override
  String get onboardPage3Subtitle =>
      'Climb the ranks, unlock achievements, and chase 100% completion.';

  @override
  String get onboardPage4Title => 'Find locals around you';

  @override
  String get onboardPage4Subtitle =>
      'We use your location to show authentic places nearby and to confirm your check-ins. Your location is never shared with other users.';

  @override
  String get onboardContinue => 'Continue';

  @override
  String get onboardGetStarted => 'Get Started';

  @override
  String get onboardAllowLocation => 'Allow location';

  @override
  String get exploreNewLocals => 'NEW LOCALS';

  @override
  String get localShares => 'LOCAL SHARES';

  @override
  String get exploreFeaturedLocations => 'FEATURED LOCATIONS';

  @override
  String get exploreFeaturedRoutes => 'FEATURED ROUTES';

  @override
  String get exploreFindLocalsToFollow => 'FIND LOCALS TO FOLLOW';

  @override
  String get exploreRecentActivity => 'RECENT ACTIVITY';

  @override
  String get exploreWeeklyRanking => 'WEEKLY RANKING';

  @override
  String get exploreAllEvents => 'All events';

  @override
  String exploreNewCategory(String category) {
    return 'NEW · $category';
  }

  @override
  String get exploreYourStory => 'Your story';

  @override
  String get exploreViewYourStory => 'View your story';

  @override
  String get exploreAddPhoto => 'Add photo';

  @override
  String get findLocalsTitle => 'Find Locals';

  @override
  String get featuredLocationsTitle => 'Featured locations';

  @override
  String get eventsRoutesTitle => 'Events & routes';

  @override
  String eventsByOrganizer(String organizer) {
    return 'By $organizer';
  }

  @override
  String eventSponsoredBy(String sponsor) {
    return 'Sponsored · $sponsor';
  }

  @override
  String get joinEventRouteStops => 'ROUTE STOPS';

  @override
  String get joinEventButton => 'Join event';

  @override
  String get joinEventJoined => 'Joined';

  @override
  String get eventCheckInNextStop => 'Check in next stop';

  @override
  String get eventRouteComplete => 'Route complete';

  @override
  String get sponsored => 'Sponsored';

  @override
  String get learnMore => 'Learn More';

  @override
  String get restaurantLocalsSeal => 'locals\' seal';

  @override
  String get authConfirmPasswordLabel => 'Confirm Password';

  @override
  String get restaurantLocalSpot => 'Local spot';

  @override
  String get authConfirmPasswordHint => '********';

  @override
  String get restaurantBeenHere => 'I\'ve been here';

  @override
  String get restaurantBeenHereDone => 'I\'ve been here ✓';

  @override
  String get restaurantDirections => 'Directions';

  @override
  String get restaurantPhotos => 'Photos';

  @override
  String get profileDetails => 'Profile Details';

  @override
  String get busniessOfTheMonth => 'Business of the month';

  @override
  String get restaurantVisitors => 'Visitors';

  @override
  String get shareLocationTitle => 'Share the location';

  @override
  String get storyDeleteTooltip => 'Delete this story';

  @override
  String get storyViewersTitle => 'Viewers';

  @override
  String get storyViewersEmpty => 'No one has viewed this story yet.';

  @override
  String get storyDeletePhotoTitle => 'Delete this photo?';

  @override
  String get storyDeletePhotoMessage =>
      'Only this story slide will be removed. Your other stories stay.';

  @override
  String get checkInConfirmed => 'CHECK-IN CONFIRMED';

  @override
  String checkInLocationYours(String locationName) {
    return '$locationName is yours.';
  }

  @override
  String get checkInAddedToMap => 'Another local added to your map.';

  @override
  String get checkInShareMoment => 'Share moment';

  @override
  String get checkInContinueExploring => 'Continue exploring';

  @override
  String get shareCardTitle => 'Share card';

  @override
  String get shareCardTapToCapture => 'Tap to capture';

  @override
  String get shareCardRetake => 'Retake';

  @override
  String get shareCardConfirm => 'Confirm';

  @override
  String get shareCardAddToStory => 'Add to Story';

  @override
  String get shareCardSaving => 'Saving...';

  @override
  String get shareCardSaved => 'Saved';

  @override
  String get shareCardSaveImage => 'Save Image';

  @override
  String get shareProfileTitle => 'Share your profile';

  @override
  String get statVisits => 'VISITS';

  @override
  String get statCities => 'CITIES';

  @override
  String get statFollowers => 'FOLLOWERS';

  @override
  String get statPoints => 'POINTS';

  @override
  String get statStops => 'STOPS';

  @override
  String get statReward => 'REWARD';

  @override
  String get statProgress => 'PROGRESS';

  @override
  String get statLevel => 'LEVEL';

  @override
  String get statCity => 'CITY';

  @override
  String get mapSearchHint => 'Search locals & places';

  @override
  String get mapSearchRecent => 'RECENT';

  @override
  String get mapSearchTrending => 'TRENDING';

  @override
  String get filtersTitle => 'Filters';

  @override
  String get filtersReset => 'Reset';

  @override
  String get filtersType => 'TYPE';

  @override
  String get filtersStatus => 'STATUS';

  @override
  String get filtersCategories => 'CATEGORIES';

  @override
  String get filtersBusinesses => 'Businesses';

  @override
  String get filtersPoi => 'POI';

  @override
  String get filtersBoth => 'Both';

  @override
  String get filtersVisited => 'Visited';

  @override
  String get filtersUnvisited => 'Unvisited';

  @override
  String get filtersApply => 'Apply filters';

  @override
  String get mapExploring => 'EXPLORING';

  @override
  String get mapCompletion => 'COMPLETION';

  @override
  String get notificationsTitle => 'Notifications';

  @override
  String get achievementsTitle => 'Achievements';

  @override
  String get missionsTitle => 'Missions';

  @override
  String get missionsSubtitle => 'Curated challenges to discover Barcelona.';

  @override
  String get missionFilterNearby => 'Nearby';

  @override
  String get missionFilterActive => 'Active';

  @override
  String get missionFilterCompleted => 'Completed';

  @override
  String get missionFilterEvents => 'Events';

  @override
  String get missionStopsSection => 'STOPS';

  @override
  String get missionContinue => 'Continue mission';

  @override
  String get achievementsUnlocked => 'UNLOCKED';

  @override
  String get achievementsKeepVisiting => 'Keep visiting to unlock more.';

  @override
  String get rankLeaderboardTitle => 'Leaderboard';

  @override
  String get rankScopeCity => 'City';

  @override
  String get rankScopeCountry => 'Country';

  @override
  String get rankScopeGlobal => 'Global';

  @override
  String get rankScopeFollowers => 'Followers';

  @override
  String get rankPeriodWeekly => 'Weekly';

  @override
  String get rankPeriodMonthly => 'Monthly';

  @override
  String get rankPeriodAllTime => 'All-time';

  @override
  String viewProfileTitle(String name) {
    return '$name\'s profile';
  }

  @override
  String get viewProfileTabPhotos => 'Photos';

  @override
  String get viewProfileTabMap => 'Map';

  @override
  String get viewProfileTabAchievements => 'Achievements';

  @override
  String viewProfileLevelLocation(int level, String location) {
    return 'Level $level · $location';
  }

  @override
  String get blockUserTitle => 'Block user';

  @override
  String blockUserMessage(String name) {
    return 'Block $name? They will not be able to see your profile.';
  }

  @override
  String get blockUserConfirm => 'Block';

  @override
  String profilePointsToNextLevel(int points, int nextLevel) {
    return '$points Pts To Level $nextLevel';
  }

  @override
  String get profileMyMap => 'My Map';

  @override
  String get profileFollowers => 'Followers';

  @override
  String get profileSavedPlace => 'Saved place';

  @override
  String get profileBlocked => 'Blocked';

  @override
  String get profileRecentAchievements => 'Recent achievements';

  @override
  String get profileLatestVisits => 'Latest visits';

  @override
  String get editProfileTitle => 'Edit profile';

  @override
  String get editProfileName => 'Name';

  @override
  String get editProfileLocation => 'Location';

  @override
  String get editProfileSaveChanges => 'Save changes';

  @override
  String get editProfileChangePassword => 'Change password';

  @override
  String get editProfileCurrentPassword => 'Current password';

  @override
  String get editProfileNewPassword => 'New password';

  @override
  String get editProfileConfirmPassword => 'Confirm password';

  @override
  String get myMapTitle => 'My map';

  @override
  String get myMapFilterAll => 'All';

  @override
  String myMapFilterVisited(int count) {
    return 'Visited · $count';
  }

  @override
  String myMapFilterUnvisited(int count) {
    return 'Unvisited · $count';
  }

  @override
  String get myMapLegendVisited => 'Visited';

  @override
  String get myMapLegendUnvisited => 'Unvisited';

  @override
  String get listTitle => 'List';

  @override
  String listFollowersCount(int count) {
    return 'Followers · $count';
  }

  @override
  String listFollowingCount(int count) {
    return 'Following · $count';
  }

  @override
  String listLevelFollowsYou(int level) {
    return 'Level $level · Follows you';
  }

  @override
  String get blockedListTitle => 'Blocked list';

  @override
  String get blockedUnblock => 'Unblock';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get settingsSectionPreferences => 'PREFERENCES';

  @override
  String get settingsSectionAccount => 'ACCOUNT';

  @override
  String get settingsSectionAbout => 'ABOUT';

  @override
  String get settingsSectionDangerZone => 'DANGER ZONE';

  @override
  String get settingsLanguage => 'Language';

  @override
  String get settingsNotification => 'Notification';

  @override
  String get settingsPrivacy => 'Privacy';

  @override
  String get settingsEditProfile => 'Edit Profile';

  @override
  String get settingsHelpSupport => 'Help & Support';

  @override
  String get settingsPrivacyPolicy => 'Privacy and policy';

  @override
  String get settingsRateLocal => 'Rate Local';

  @override
  String get settingsLogOut => 'Log out';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageSpanish => 'Spanish';

  @override
  String get languagePickerTitle => 'Choose language';

  @override
  String get privacyTitle => 'Privacy';

  @override
  String get privacySectionProfileVisibility => 'PROFILE VISIBILITY';

  @override
  String get privacySectionPhotoVisibility => 'PHOTO VISIBILITY';

  @override
  String get privacySectionLocationPermission => 'LOCATION PERMISSION';

  @override
  String get privacySectionLeaderboard => 'SHOW ON LEADERBOARD';

  @override
  String get privacyPublic => 'Public';

  @override
  String get privacyPrivate => 'Private';

  @override
  String get privacyFollowersOnly => 'Followers only';

  @override
  String get privacyAllTime => 'All time';

  @override
  String get privacyWhileUsingApp => 'While using app';

  @override
  String get privacyOn => 'On';

  @override
  String get privacyOff => 'Off';

  @override
  String get privacyDataTitle => 'Privacy & Data';

  @override
  String get privacyDeleteAccount => 'Delete my account';

  @override
  String get privacyPolicyLink => 'Privacy policy';

  @override
  String get termsOfUseLink => 'Terms of use';

  @override
  String get termsOfUseTitle => 'Terms of use';

  @override
  String get privacyPolicyTitle => 'Privacy policy';

  @override
  String get privacyDataEncryptedTitle => 'Your data is encrypted';

  @override
  String get privacyDataEncryptedSubtitle =>
      'Health information is stored locally and synced securely.';

  @override
  String get notificationMissionAlerts => 'Mission alerts';

  @override
  String get notificationMissionAlertsDesc =>
      'When a new mission is available.';

  @override
  String get notificationEvents => 'Events';

  @override
  String get notificationEventsDesc => 'Festivals and sponsored routes.';

  @override
  String get notificationAnnouncements => 'Announcements';

  @override
  String get notificationAnnouncementsDesc => 'Festivals and sponsored routes.';

  @override
  String get helpSupportTitle => 'Help & Support';

  @override
  String get helpSubjectLabel => 'Subject';

  @override
  String get helpMessageLabel => 'Message';

  @override
  String get helpMessageHint => 'Describe your issue or question...';

  @override
  String get helpSending => 'Sending...';

  @override
  String get helpSend => 'Send';

  @override
  String helpVersion(String version) {
    return 'Version $version';
  }

  @override
  String get helpEmailTo => 'To';

  @override
  String get subscriptionTitle => 'Manage Subscription';

  @override
  String get subscriptionCurrentPlan => 'Current plan';

  @override
  String get subscriptionPremiumUnlocked => 'All premium features unlocked';

  @override
  String get subscriptionBillingHistory => 'BILLING HISTORY';

  @override
  String get subscriptionUpdatePayment => 'Update';

  @override
  String get subscriptionAutoRenew => 'Auto-renew';

  @override
  String get subscriptionAutoRenewDesc => 'Will renew automatically each month';

  @override
  String get subscriptionUpgradeYearly => 'Upgrade to Yearly';

  @override
  String get subscriptionYearlySavings => 'Save 50% · \$4.92/mo';

  @override
  String get subscriptionSwitch => 'Switch';

  @override
  String get subscriptionCancel => 'Cancel subscription';

  @override
  String get filterCategoryRestaurant => 'Restaurant';

  @override
  String get filterCategoryBar => 'Bar';

  @override
  String get filterCategoryCafe => 'Cafe';

  @override
  String get filterCategoryBakery => 'Bakery';

  @override
  String get filterCategoryShop => 'Shop';

  @override
  String get filterCategoryMarket => 'Market';

  @override
  String get filterCategoryMonument => 'Monument';

  @override
  String get filterCategoryCultural => 'Cultural Space';

  @override
  String get filterCategoryViewpoint => 'Viewpoint';

  @override
  String get filterCategorySquare => 'Square';

  @override
  String get filterCategoryOther => 'Other';

  @override
  String get snackbarLinkCopied => 'Link copied';

  @override
  String get snackbarCaptureFailed => 'Failed to capture photo';

  @override
  String get snackbarThanksFeedback => 'Thanks for your feedback!';

  @override
  String get snackbarProfileUpdated => 'Profile updated';

  @override
  String get snackbarPasswordsNoMatch => 'Passwords do not match';

  @override
  String get snackbarPasswordChanged => 'Password changed';

  @override
  String get snackbarPasswordChangeFailed => 'Could not change password';

  @override
  String get snackbarStoryAdded => 'Story added';

  @override
  String photoLikesCount(int count) {
    return '$count likes';
  }

  @override
  String get savedPlacesTitle => 'Saved places';

  @override
  String get storyJustNow => 'Just now';

  @override
  String get snackbarCapturePhotoFirst => 'Capture a photo first';

  @override
  String get helpWriteMessage => 'Please write a message';

  @override
  String get helpOpeningEmail => 'Opening email app';

  @override
  String get helpCouldNotOpenEmail => 'Could not open email app';

  @override
  String get cameraNoAvailable => 'No camera available on this device.';

  @override
  String get cameraCouldNotOpen =>
      'Could not open the camera. Please try again.';

  @override
  String get shareCardTakePhoto => 'Take photo';

  @override
  String get shareCardChooseGallery => 'Choose from gallery';

  @override
  String get likes => 'LIKES';
}
