import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:locals/features/explore/restaurant_view_details/repository/qr_discount_repository.dart';

/// Drives the QR scan screen when it's used to claim a discount
/// (entry point: Settings page).
class QRDiscountController extends ChangeNotifier {
  final QRDiscountRepository repo;
  bool isLoading = false;

  QRDiscountController(this.repo);

  Future<void> onQRScanned(BuildContext context, String qrToken) async {
    isLoading = true;
    notifyListeners();

    try {
      final result = await repo.claimDiscount(qrToken: qrToken);

      if (context.mounted) {
        context.pushReplacement('/qr-discount-result', extra: result);
      }
    } catch (e) {
      debugPrint('QR discount claim error: $e');
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Something went wrong. Please try again.'),
          ),
        );
      }
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}