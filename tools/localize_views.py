#!/usr/bin/env python3
"""Batch-localize static UI strings in view files."""
import os
import re

ROOT = os.path.join(os.path.dirname(__file__), '..')
IMPORT = "import 'package:locals/core/localization/l10n_extensions.dart';\n"

# Order matters: longer/more specific patterns first
REPLACEMENTS = [
    # Titles
    (r"title: 'Privacy & Data'", "title: context.l10n.privacyDataTitle"),
    (r'title: "Privacy & Data"', "title: context.l10n.privacyDataTitle"),
    (r"title: 'Saved places'", "title: context.l10n.savedPlacesTitle"),
    (r"title: 'My map'", "title: context.l10n.myMapTitle"),
    (r"title: 'Edit profile'", "title: context.l10n.editProfileTitle"),
    (r"title: 'Terms of use'", "title: context.l10n.termsOfUseTitle"),
    (r"title: 'Privacy policy'", "title: context.l10n.privacyPolicyTitle"),
    (r"title: 'Help & Support'", "title: context.l10n.helpSupportTitle"),
    (r"title: 'Share card'", "title: context.l10n.shareCardTitle"),
    (r"title: 'Events & routes'", "title: context.l10n.eventsRoutesTitle"),
    (r"title: 'Featured locations'", "title: context.l10n.featuredLocationsTitle"),
    (r"title: 'Find Locals'", "title: context.l10n.findLocalsTitle"),
    (r"title: 'Notifications'", "title: context.l10n.notificationsTitle"),
    (r"title: 'Filters'", "title: context.l10n.filtersTitle"),
    (r"title: 'Achievements'", "title: context.l10n.achievementsTitle"),
    (r"title: 'Blocked list'", "title: context.l10n.blockedListTitle"),
    (r"title: 'Manage Subscription'", "title: context.l10n.subscriptionTitle"),
    (r"title: 'Privacy'", "title: context.l10n.privacyTitle"),
    (r"title: 'List'", "title: context.l10n.listTitle"),
    (r"title: 'Share your profile'", "title: context.l10n.shareProfileTitle"),
    (r"title: 'Share the location'", "title: context.l10n.shareLocationTitle"),
    (r"title: 'Join locals'", "title: context.l10n.signupTitle"),
    (r"title: 'Reset your password'", "title: context.l10n.otpResetPasswordTitle"),
    (r"title: 'Create a new password'", "title: context.l10n.setPasswordTitle"),
    (r"subtitle: 'Start collecting authentic places.'", "subtitle: context.l10n.signupSubtitle"),
    (r"subtitle: 'Use the same mail that you used to create the account'", "subtitle: context.l10n.otpResetPasswordSubtitle"),
    (r"subtitle: 'Create something unique but rememberable'", "subtitle: context.l10n.setPasswordSubtitle"),
    # Labels
    (r"label: 'Photos'", "label: context.l10n.viewProfileTabPhotos"),
    (r"label: 'Map'", "label: context.l10n.viewProfileTabMap"),
    (r"label: 'Achievements'", "label: context.l10n.viewProfileTabAchievements"),
    (r"label: 'Name'", "label: context.l10n.editProfileName"),
    (r"label: 'Location'", "label: context.l10n.editProfileLocation"),
    (r"label: 'Save changes'", "label: context.l10n.editProfileSaveChanges"),
    (r"label: 'Subject'", "label: context.l10n.helpSubjectLabel"),
    (r"label: 'Message'", "label: context.l10n.helpMessageLabel"),
    (r"label: 'Current password'", "label: context.l10n.editProfileCurrentPassword"),
    (r"label: 'New password'", "label: context.l10n.editProfileNewPassword"),
    (r"label: 'Confirm password'", "label: context.l10n.editProfileConfirmPassword"),
    (r"label: 'Change password'", "label: context.l10n.editProfileChangePassword"),
    (r"label: 'Log in'", "label: context.l10n.loginButton"),
    (r"label: 'Create account'", "label: context.l10n.signupButton"),
    (r"label: 'Verify OTP'", "label: context.l10n.otpVerifyButton"),
    (r"label: 'Request OTP'", "label: context.l10n.requestOtpButton"),
    (r"label: 'All'", "label: context.l10n.myMapFilterAll"),
    (r"label: 'Add to Story'", "label: context.l10n.shareCardAddToStory"),
    (r"label: 'VISITS'", "label: context.l10n.statVisits"),
    (r"label: 'CITIES'", "label: context.l10n.statCities"),
    (r"label: 'FOLLOWERS'", "label: context.l10n.statFollowers"),
    (r"label: 'POINTS'", "label: context.l10n.statPoints"),
    (r"label: 'STOPS'", "label: context.l10n.statStops"),
    (r"label: 'REWARD'", "label: context.l10n.statReward"),
    (r"label: 'PROGRESS'", "label: context.l10n.statProgress"),
    (r"label: 'LEVEL'", "label: context.l10n.statLevel"),
    (r"label: 'CITY'", "label: context.l10n.statCity"),
    (r"label: 'My Map'", "label: context.l10n.profileMyMap"),
    (r"label: 'Followers'", "label: context.l10n.profileFollowers"),
    (r"label: 'Saved place'", "label: context.l10n.profileSavedPlace"),
    (r"label: 'Blocked'", "label: context.l10n.profileBlocked"),
    (r"label: 'Not now'", "label: context.l10n.onboardNotNow"),
    # Hints
    (r"hintText: 'Search locals & places'", "hintText: context.l10n.mapSearchHint"),
    (r"hint: 'Describe your issue or question...'", "hint: context.l10n.helpMessageHint"),
    (r"hint: 'Alex Vidal'", "hint: context.l10n.authNameHint"),
    # Section titles
    (r"title: 'NEW LOCALS'", "title: context.l10n.exploreNewLocals"),
    (r"title: 'FEATURED LOCATIONS'", "title: context.l10n.exploreFeaturedLocations"),
    (r"title: 'FEATURED ROUTES'", "title: context.l10n.exploreFeaturedRoutes"),
    (r"title: 'FIND LOCALS TO FOLLOW'", "title: context.l10n.exploreFindLocalsToFollow"),
    (r"title: 'RECENT ACTIVITY'", "title: context.l10n.exploreRecentActivity"),
    (r"title: 'WEEKLY RANKING'", "title: context.l10n.exploreWeeklyRanking"),
    (r"title: 'RECENT'", "title: context.l10n.mapSearchRecent"),
    (r"title: 'TRENDING'", "title: context.l10n.mapSearchTrending"),
    (r"actionLabel: 'See all'", "actionLabel: context.l10n.commonSeeAll"),
    (r"actionLabel: 'All events'", "actionLabel: context.l10n.exploreAllEvents"),
    (r"actionLabel: 'View all'", "actionLabel: context.l10n.commonViewAll"),
    # Text widgets - quoted strings
    (r"'Leaderboard'", "context.l10n.rankLeaderboardTitle"),
    (r"'Missions'", "context.l10n.missionsTitle"),
    (r"'Achievements'", "context.l10n.achievementsTitle"),
    (r"'Curated challenges to discover Barcelona.'", "context.l10n.missionsSubtitle"),
    (r"'Recent achievements'", "context.l10n.profileRecentAchievements"),
    (r"'Latest visits'", "context.l10n.profileLatestVisits"),
    (r"'Photos'", "context.l10n.restaurantPhotos"),
    (r"'Visitors'", "context.l10n.restaurantVisitors"),
    (r"'Directions'", "context.l10n.restaurantDirections"),
    (r"'Progress'", "context.l10n.commonProgress"),
    (r"'Check in next stop'", "context.l10n.eventCheckInNextStop"),
    (r"'Route complete'", "context.l10n.eventRouteComplete"),
    (r"'Visited'", "context.l10n.myMapLegendVisited"),
    (r"'Unvisited'", "context.l10n.myMapLegendUnvisited"),
    (r"'Cancel'", "context.l10n.commonCancel"),
    (r"'Reset'", "context.l10n.filtersReset"),
    (r"'Apply filters'", "context.l10n.filtersApply"),
    (r"'CATEGORIES'", "context.l10n.filtersCategories"),
    (r"'TYPE'", "context.l10n.filtersType"),
    (r"'STATUS'", "context.l10n.filtersStatus"),
    (r"'Businesses'", "context.l10n.filtersBusinesses"),
    (r"'POI'", "context.l10n.filtersPoi"),
    (r"'Both'", "context.l10n.filtersBoth"),
    (r"'Visited'", "context.l10n.filtersVisited"),
    (r"'Unvisited'", "context.l10n.filtersUnvisited"),
    (r"'EXPLORING'", "context.l10n.mapExploring"),
    (r"'COMPLETION'", "context.l10n.mapCompletion"),
    (r"'ROUTE STOPS'", "context.l10n.joinEventRouteStops"),
    (r"'Join event'", "context.l10n.joinEventButton"),
    (r"'Joined'", "context.l10n.joinEventJoined"),
    (r"'CHECK-IN CONFIRMED'", "context.l10n.checkInConfirmed"),
    (r"'Another local added to your map.'", "context.l10n.checkInAddedToMap"),
    (r"'Share moment'", "context.l10n.checkInShareMoment"),
    (r"'Continue exploring'", "context.l10n.checkInContinueExploring"),
    (r"'Tap to capture'", "context.l10n.shareCardTapToCapture"),
    (r"'Retake'", "context.l10n.shareCardRetake"),
    (r"'Confirm'", "context.l10n.shareCardConfirm"),
    (r"'Done'", "context.l10n.commonDone"),
    (r"'Saving...'", "context.l10n.shareCardSaving"),
    (r"'Saved'", "context.l10n.shareCardSaved"),
    (r"'Save Image'", "context.l10n.shareCardSaveImage"),
    (r"'UNLOCKED'", "context.l10n.achievementsUnlocked"),
    (r"'Keep visiting to unlock more.'", "context.l10n.achievementsKeepVisiting"),
    (r"'STOPS'", "context.l10n.missionStopsSection"),
    (r"'Continue mission'", "context.l10n.missionContinue"),
    (r"'BILLING HISTORY'", "context.l10n.subscriptionBillingHistory"),
    (r"'Update'", "context.l10n.subscriptionUpdatePayment"),
    (r"'Auto-renew'", "context.l10n.subscriptionAutoRenew"),
    (r"'Will renew automatically each month'", "context.l10n.subscriptionAutoRenewDesc"),
    (r"'Upgrade to Yearly'", "context.l10n.subscriptionUpgradeYearly"),
    (r"'Switch'", "context.l10n.subscriptionSwitch"),
    (r"'Cancel subscription'", "context.l10n.subscriptionCancel"),
    (r"'Current plan'", "context.l10n.subscriptionCurrentPlan"),
    (r"'All premium features unlocked'", "context.l10n.subscriptionPremiumUnlocked"),
    (r"'Unblock'", "context.l10n.blockedUnblock"),
    (r"'Delete my account'", "context.l10n.privacyDeleteAccount"),
    (r"'Privacy policy'", "context.l10n.privacyPolicyLink"),
    (r"'Terms of use'", "context.l10n.termsOfUseLink"),
    (r"'To'", "context.l10n.helpEmailTo"),
    (r"'Skip'", "context.l10n.onboardSkip"),
    (r"'Verify'", "context.l10n.otpVerifyHeader"),
    (r"'Email Verified'", "context.l10n.otpEmailVerifiedTitle"),
    (r"'Your email has been verified successfully.'", "context.l10n.otpEmailVerifiedMessage"),
    (r"'Already a local? '", "context.l10n.signupAlreadyLocal"),
    (r"'Join locals'", "context.l10n.signupTitle"),
    (r"'Start collecting authentic places.'", "context.l10n.signupSubtitle"),
    (r"'Viewers'", "context.l10n.storyViewersTitle"),
    (r"'No one has viewed this story yet.'", "context.l10n.storyViewersEmpty"),
    (r"'Delete this story'", "context.l10n.storyDeleteTooltip"),
    (r"'Show more'", "context.l10n.commonShowMore"),
    (r"'Show less'", "context.l10n.commonShowLess"),
    (r"'Block'", "context.l10n.commonBlock"),
    (r"'Copy'", "context.l10n.commonCopy"),
    (r"'or continue with'", "context.l10n.authOrContinueWith"),
    (r"'Google'", "context.l10n.authGoogle"),
    (r"'Password must contain:'", "context.l10n.authPasswordMustContain"),
    (r"'Back'", "context.l10n.commonBack"),
    (r"'Just now'", "context.l10n.storyJustNow"),
    (r"'Your data is encrypted'", "context.l10n.privacyDataEncryptedTitle"),
    (r"'Health information is stored locally and synced securely.'", "context.l10n.privacyDataEncryptedSubtitle"),
    # Ternary follow labels
    (r"user\.isFollowing \? 'Following' : 'Follow'", "user.isFollowing ? context.l10n.commonFollowing : context.l10n.commonFollow"),
    (r"isFollowing \? 'Following' : 'Follow'", "isFollowing ? context.l10n.commonFollowing : context.l10n.commonFollow"),
    (r"event\.isJoined \? 'Joined' : 'Join event'", "event.isJoined ? context.l10n.joinEventJoined : context.l10n.joinEventButton"),
    (r"isExpanded \? 'Show less' : 'Show more'", "isExpanded ? context.l10n.commonShowLess : context.l10n.commonShowMore"),
    (r"controller\.isSending \? 'Sending...' : 'Send'", "controller.isSending ? context.l10n.helpSending : context.l10n.helpSend"),
    (r"state\.canCheckIn \? 'Check in next stop' : 'Route complete'", "state.canCheckIn ? context.l10n.eventCheckInNextStop : context.l10n.eventRouteComplete"),
    (r"hasQuery \? query : 'Search locals & places'", "hasQuery ? query : context.l10n.mapSearchHint"),
    # const Text removals where needed - handle separately
    (r"const Text\('Retake'\)", "Text(context.l10n.shareCardRetake)"),
    (r"const Text\('Confirm'\)", "Text(context.l10n.shareCardConfirm)"),
    (r"const Text\('Failed to capture photo'\)", "Text(context.l10n.snackbarCaptureFailed)"),
    (r"const Text\('Link copied'\)", "Text(context.l10n.snackbarLinkCopied)"),
    (r"const Text\('Delete this photo\?'\)", "Text(context.l10n.storyDeletePhotoTitle)"),
    (r"const Text\('Cancel'\)", "Text(context.l10n.commonCancel)"),
    (r"const Text\('Block user'\)", "Text(context.l10n.blockUserTitle)"),
    (r"const Text\('Block'\)", "Text(context.l10n.blockUserConfirm)"),
    (r"const Text\(\s*'Only this story slide will be removed\. Your other stories stay\.',\s*\)", "Text(context.l10n.storyDeletePhotoMessage)"),
    # SnackBars
    (r"const SnackBar\(content: Text\('Story added'\)\)", "SnackBar(content: Text(context.l10n.snackbarStoryAdded))"),
    (r"const SnackBar\(content: Text\('Profile updated'\)\)", "SnackBar(content: Text(context.l10n.snackbarProfileUpdated))"),
    (r"const SnackBar\(content: Text\('Passwords do not match'\)\)", "SnackBar(content: Text(context.l10n.snackbarPasswordsNoMatch))"),
    (r"const SnackBar\(content: Text\('Password changed'\)\)", "SnackBar(content: Text(context.l10n.snackbarPasswordChanged))"),
    (r"const SnackBar\(content: Text\('Could not change password'\)\)", "SnackBar(content: Text(context.l10n.snackbarPasswordChangeFailed))"),
    (r"const SnackBar\(content: Text\('Capture a photo first'\)\)", "SnackBar(content: Text(context.l10n.snackbarCapturePhotoFirst))"),
    (r"const SnackBar\(content: Text\('Please write a message'\)\)", "SnackBar(content: Text(context.l10n.helpWriteMessage))"),
    (r"const SnackBar\(content: Text\('Opening email app'\)\)", "SnackBar(content: Text(context.l10n.helpOpeningEmail))"),
    (r"const SnackBar\(content: Text\('Could not open email app'\)\)", "SnackBar(content: Text(context.l10n.helpCouldNotOpenEmail))"),
    # Camera errors
    (r"_errorMessage = 'No camera available on this device\.';", "_errorMessage = context.l10n.cameraNoAvailable;"),
    (r"_errorMessage = 'Could not open the camera\. Please try again\.';", "_errorMessage = context.l10n.cameraCouldNotOpen;"),
    # barrier labels
    (r"barrierLabel: 'Dismiss'", "barrierLabel: context.l10n.commonDismiss"),
    (r"label: 'Email'", "label: context.l10n.authEmailLabel"),
    (r"label: 'Password'", "label: context.l10n.authPasswordLabel"),
    (r"label: 'New Password'", "label: context.l10n.setPasswordNewLabel"),
    (r"label: 'Confirm Password'", "label: context.l10n.setPasswordConfirmLabel"),
    (r"hint: 'Something secure'", "hint: context.l10n.setPasswordNewHint"),
    (r"hint: 'Confirm your password'", "hint: context.l10n.setPasswordConfirmHint"),
    (r"label: 'Reset Password'", "label: context.l10n.setPasswordButton"),
    (r"'Welcome back'", "context.l10n.loginWelcomeTitle"),
    (r"'Your locals are waiting\.'", "context.l10n.loginWelcomeSubtitle"),
    (r"'Remember me'", "context.l10n.loginRememberMe"),
    (r"'Forgot password\?'", "context.l10n.loginForgotPassword"),
    (r"'New here\? '", "context.l10n.loginNewHere"),
    (r"'Create account'", "context.l10n.loginCreateAccount"),
    (r"'Back to '", "context.l10n.setPasswordBackTo"),
    (r"'Log in'", "context.l10n.authLogIn"),
    (r"'Resend'", "context.l10n.otpResend"),
    (r"'Password Changed'", "context.l10n.setPasswordSuccessTitle"),
    (r"'Your password has been changed successfully\.'", "context.l10n.setPasswordSuccessMessage"),
    (r"'View all'", "context.l10n.commonViewAll"),
    (r"'Following'", "context.l10n.commonFollowing"),
    (r"'Change password'", "context.l10n.editProfileChangePassword"),
    (r"'POINTS'", "context.l10n.statPoints"),
    (r"'PROGRESS'", "context.l10n.statProgress"),
    # Rank/mission filter maps - skip, handled manually
]

SKIP_FILES = {
    'premium_confirm_dialog.dart',
    'bottom_nav_bar.dart',
    'missions_filter_chips.dart',
    'rank_scope_chips.dart',
    'rank_period_tabs.dart',
}

def needs_import(content):
    return 'l10n_extensions' not in content and 'context.l10n' in content

def add_import(content):
    if 'l10n_extensions' in content:
        return content
    # Add after last import
    lines = content.split('\n')
    last_import = 0
    for i, line in enumerate(lines):
        if line.startswith('import '):
            last_import = i
    lines.insert(last_import + 1, IMPORT.strip())
    return '\n'.join(lines)

def process_file(path):
    with open(path, 'r', encoding='utf-8') as f:
        original = f.read()
    content = original
    for pattern, repl in REPLACEMENTS:
        content = re.sub(pattern, repl, content)
    if content == original:
        return False
    if needs_import(content):
        content = add_import(content)
    with open(path, 'w', encoding='utf-8') as f:
        f.write(content)
    return True

def main():
    modified = []
    dirs = [
        os.path.join(ROOT, 'lib', 'features'),
        os.path.join(ROOT, 'lib', 'shared', 'components'),
    ]
    for base in dirs:
        for root, _, files in os.walk(base):
            norm_root = root.replace('\\', '/')
            is_view = '/view' in norm_root
            is_shared = 'shared/components' in norm_root
            is_controller = '/controller' in norm_root
            if not (is_view or is_shared or is_controller):
                continue
            for name in files:
                if not name.endswith('.dart'):
                    continue
                if name in SKIP_FILES:
                    continue
                path = os.path.join(root, name)
                if process_file(path):
                    modified.append(path)
    print(f'Modified {len(modified)} files')
    for p in sorted(modified):
        print(p)

if __name__ == '__main__':
    main()
