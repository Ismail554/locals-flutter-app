class QRCheckInResult {
  final bool success;
  final String message;
  final String? status;
  final double? distanceMeters;
  final String? placeName;
  final int? pointsEarned;
  final int? newTotalPoints;
  final int? newLevel;
  final double? cityCompletionPercentage;
  final bool missionCompleted;
  final List<String> unlockedAchievements;

  const QRCheckInResult({
    required this.success,
    required this.message,
    this.status,
    this.distanceMeters,
    this.placeName,
    this.pointsEarned,
    this.newTotalPoints,
    this.newLevel,
    this.cityCompletionPercentage,
    this.missionCompleted = false,
    this.unlockedAchievements = const [],
  });

  factory QRCheckInResult.fromApi(Map<String, dynamic> json) {
    final gamification = json['gamification'] as Map<String, dynamic>?;

    return QRCheckInResult(
      success: json['success'] as bool? ?? false,
      message: json['message'] as String? ?? 'Unknown response',
      status: gamification?['status'] as String?,
      distanceMeters: (gamification?['distance_meters'] as num?)?.toDouble(),
      placeName: gamification?['place_name'] as String?,
      pointsEarned: (gamification?['points_earned'] as num?)?.toInt(),
      newTotalPoints: (gamification?['new_total_points'] as num?)?.toInt(),
      newLevel: (gamification?['new_level'] as num?)?.toInt(),
      cityCompletionPercentage:
          (gamification?['city_completion_percentage'] as num?)?.toDouble(),
      missionCompleted: gamification?['mission_completed'] as bool? ?? false,
      unlockedAchievements:
          (gamification?['unlocked_achievements'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          const [],
    );
  }

  bool get isTooFar => status == 'too_far';

  bool get isSuccess => success && (status == 'success' || status == null);

  String get displayMessage {
    switch (status) {
      case 'too_far':
        if (distanceMeters != null) {
          return 'You are ${distanceMeters!.toStringAsFixed(0)} meters away from the venue. Please move closer and try again.';
        }
        return 'You are too far from the venue. Please move closer and try again.';

      case 'invalid_qr':
        return 'This QR code is invalid.';

      case 'already_checked_in':
        return 'You have already checked in.';

      case 'expired':
        return 'This QR code has expired.';

      case 'success':
        return message;

      default:
        return message;
    }
  }
}
