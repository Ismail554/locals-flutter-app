import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:locals/core/localization/l10n_extensions.dart';
import 'package:locals/features/explore/restaurant_view_details/repository/qr_checkin_repository.dart';
import 'package:locals/features/map/map/controller/location_service.dart';

class QRCheckInController extends ChangeNotifier {
  final QRCheckInRepository repo;
  final String? placeId;
  bool isLoading = false;

  QRCheckInController(this.repo, {this.placeId});

  Future<void> onQRScanned(BuildContext context, String qrToken) async {
    isLoading = true;
    notifyListeners();

    try {
      final currentLoc = await LocationService.currentLocation();

      final result = await repo.qrCheckIn(
        qrToken: qrToken,
        latitude: currentLoc.latitude,
        longitude: currentLoc.longitude,
      );

      if (context.mounted) {
        context.pushReplacement(
          '/qr-scan-status',
          extra: result,
        );
      }
    } catch (e) {
      debugPrint('QR Check-in error: $e');
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(context.l10n.qrScanFailed,)),
        );
      }
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}