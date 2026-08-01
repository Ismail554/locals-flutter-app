import 'package:locals/core/network/api_client.dart';
import 'package:locals/features/explore/restaurant_view_details/model/qr_discount_result.dart';

abstract class QRDiscountRepository {
  Future<QRDiscountResult> claimDiscount({required String qrToken});
}

class QRDiscountRepositoryImpl implements QRDiscountRepository {
  final ApiClient _client = ApiClient();

  @override
  Future<QRDiscountResult> claimDiscount({required String qrToken}) async {
    try {
      final response = await _client.post(
        '/gamification/qr-discount/claim/',
        {"qr_token": qrToken},
      );

      return QRDiscountResult.fromApi(response);
    } on ApiException catch (e) {
      // ApiClient._extractErrorMessage already pulled the right string out
      // of the error body (body['detail'], then body['message'], etc.),
      // so just surface it as-is instead of a generic fallback.
      return QRDiscountResult(success: false, message: e.message);
    } catch (e) {
      return const QRDiscountResult(
        success: false,
        message: 'Failed to claim discount. Please try again.',
      );
    }
  }
}