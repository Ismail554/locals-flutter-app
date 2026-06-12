enum ProfileVisibility { public, private }

enum PhotoVisibility { public, followersOnly }

enum LocationPermission { allTime, whileUsingApp }

enum LeaderboardVisibility { on, off }

class PrivacySetting<T> {
  final String label;
  final T value;
  final List<PrivacyOption<T>> options;

  const PrivacySetting({
    required this.label,
    required this.value,
    required this.options,
  });

  PrivacySetting<T> copyWith({T? value}) {
    return PrivacySetting<T>(
      label: label,
      value: value ?? this.value,
      options: options,
    );
  }
}

class PrivacyOption<T> {
  final String id;
  final String label;
  final T value;

  const PrivacyOption({
    required this.id,
    required this.label,
    required this.value,
  });
}

class PrivacyModel {
  final PrivacySetting<ProfileVisibility> profileVisibility;
  final PrivacySetting<PhotoVisibility> photoVisibility;
  final PrivacySetting<LocationPermission> locationPermission;
  final PrivacySetting<LeaderboardVisibility> leaderboardVisibility;

  const PrivacyModel({
    this.profileVisibility = const PrivacySetting(
      label: 'PROFILE VISIBILITY',
      value: ProfileVisibility.public,
      options: [
        PrivacyOption(id: 'public', label: 'Public', value: ProfileVisibility.public),
        PrivacyOption(id: 'private', label: 'Private', value: ProfileVisibility.private),
      ],
    ),
    this.photoVisibility = const PrivacySetting(
      label: 'PHOTO VISIBILITY',
      value: PhotoVisibility.followersOnly,
      options: [
        PrivacyOption(id: 'public', label: 'Public', value: PhotoVisibility.public),
        PrivacyOption(
          id: 'followers_only',
          label: 'Followers only',
          value: PhotoVisibility.followersOnly,
        ),
      ],
    ),
    this.locationPermission = const PrivacySetting(
      label: 'LOCATION PERMISSION',
      value: LocationPermission.whileUsingApp,
      options: [
        PrivacyOption(id: 'all_time', label: 'All time', value: LocationPermission.allTime),
        PrivacyOption(
          id: 'while_using',
          label: 'While using app',
          value: LocationPermission.whileUsingApp,
        ),
      ],
    ),
    this.leaderboardVisibility = const PrivacySetting(
      label: 'SHOW ON LEADERBOARD',
      value: LeaderboardVisibility.on,
      options: [
        PrivacyOption(id: 'on', label: 'On', value: LeaderboardVisibility.on),
        PrivacyOption(id: 'off', label: 'Off', value: LeaderboardVisibility.off),
      ],
    ),
  });

  PrivacyModel copyWith({
    PrivacySetting<ProfileVisibility>? profileVisibility,
    PrivacySetting<PhotoVisibility>? photoVisibility,
    PrivacySetting<LocationPermission>? locationPermission,
    PrivacySetting<LeaderboardVisibility>? leaderboardVisibility,
  }) {
    return PrivacyModel(
      profileVisibility: profileVisibility ?? this.profileVisibility,
      photoVisibility: photoVisibility ?? this.photoVisibility,
      locationPermission: locationPermission ?? this.locationPermission,
      leaderboardVisibility:
          leaderboardVisibility ?? this.leaderboardVisibility,
    );
  }
}
