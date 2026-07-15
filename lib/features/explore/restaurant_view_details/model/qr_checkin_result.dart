class QRCheckInResult {
  final bool success;
  final String message;
  final String? status; // "success", "too_far", "invalid_qr", etc.
  final double? distanceMeters;
  final String? placeName;

  const QRCheckInResult({
    required this.success,
    required this.message,
    this.status,
    this.distanceMeters,
    this.placeName,
  });

  factory QRCheckInResult.fromApi(Map<String, dynamic> json) {
    final gamification = json['gamification'] as Map<String, dynamic>?;

    return QRCheckInResult(
      success: json['success'] as bool? ?? false,
      message: json['message'] as String? ?? 'Unknown response',
      status: gamification?['status'] as String?,
      distanceMeters: gamification?['distance_meters'] as double?,
      placeName: gamification?['place_name'] as String?,
    );
  }

  bool get isTooFar => status == 'too_far';
  bool get isSuccess => success && (status == 'success' || status == null);
}