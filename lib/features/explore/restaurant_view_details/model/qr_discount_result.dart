/// Result of scanning a QR code to claim a place discount.
/// Maps POST /gamification/qr-discount/claim/
class QRDiscountResult {
  final bool success;
  final String message;
  final DiscountInfo? discount;
  final int? pointsSpent;
  final DateTime? createdAt;

  const QRDiscountResult({
    required this.success,
    required this.message,
    this.discount,
    this.pointsSpent,
    this.createdAt,
  });

  factory QRDiscountResult.fromApi(Map<String, dynamic> json) {
    // Success shape: { id, discount: {...}, points_spent, created_at }
    final discountJson = json['discount'] as Map<String, dynamic>?;
    if (discountJson != null) {
      return QRDiscountResult(
        success: true,
        message: 'Discount claimed successfully.',
        discount: DiscountInfo.fromApi(discountJson),
        pointsSpent: (json['points_spent'] as num?)?.toInt(),
        createdAt: DateTime.tryParse(json['created_at']?.toString() ?? ''),
      );
    }

    // Failure shape: { success: false, message, errors: { detail }, status_code }
    final errors = json['errors'] as Map<String, dynamic>?;
    return QRDiscountResult(
      success: json['success'] as bool? ?? false,
      message: (errors?['detail'] as String?) ??
          (json['message'] as String?) ??
          'Unable to claim this discount.',
    );
  }
}

class DiscountInfo {
  final int id;
  final String title;
  final String description;
  final int costInPoints;
  final int frequencyLimitHours;

  const DiscountInfo({
    required this.id,
    required this.title,
    required this.description,
    required this.costInPoints,
    required this.frequencyLimitHours,
  });

  factory DiscountInfo.fromApi(Map<String, dynamic> json) {
    return DiscountInfo(
      id: (json['id'] as num?)?.toInt() ?? 0,
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      costInPoints: (json['cost_in_points'] as num?)?.toInt() ?? 0,
      frequencyLimitHours:
          (json['frequency_limit_hours'] as num?)?.toInt() ?? 0,
    );
  }
}