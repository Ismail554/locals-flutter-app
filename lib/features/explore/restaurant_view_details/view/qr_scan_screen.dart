import 'package:ai_barcode_scanner/ai_barcode_scanner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:locals/core/localization/l10n_extensions.dart';
import 'package:locals/features/map/map/controller/location_service.dart';
import 'package:locals/shared/theme/app_colors.dart';
import 'package:provider/provider.dart';

import '../controller/qr_checkin_controller.dart';
import '../repository/qr_checkin_repository.dart';

class QRScanScreen extends StatelessWidget {
  final String? placeId;

  const QRScanScreen({super.key, this.placeId});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) =>
          QRCheckInController(QRCheckInRepositoryImpl(), placeId: placeId),
      child: const _QRScanView(),
    );
  }
}

class _QRScanView extends StatefulWidget {
  const _QRScanView();

  @override
  State<_QRScanView> createState() => _QRScanViewState();
}

class _QRScanViewState extends State<_QRScanView> {
  bool isProcessing = false;

  void _handleScan(BarcodeCapture capture) async {
    if (isProcessing) return;

    final barcode = capture.barcodes.first;
    final value = barcode.rawValue;

    if (value == null || value.isEmpty) return;

    isProcessing = true;
    final controller = context.read<QRCheckInController>();

    try {
      final currentLoc = await LocationService.currentLocation();

      final result = await controller.repo.qrCheckIn(
        qrToken: value,
        latitude: currentLoc.latitude,
        longitude: currentLoc.longitude,
        // latitude: 41.387100,
        // longitude: 2.175400
      );

      // Go back and show message
      if (mounted) {
        Navigator.pop(context); // Go back to previous screen

        // Show result message as Snackbar
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(result.message),
            backgroundColor: result.isSuccess ? Colors.green : Colors.orange,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    } catch (e) {
      debugPrint("QR Scan error: $e");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(context.l10n.qrScanFailed),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      isProcessing = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<QRCheckInController>();

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(context.l10n.qrCodeScanTitle),
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: Stack(
        children: [
          AiBarcodeScanner(
            onDetect: _handleScan,
            // hideGalleryButton: false,
            // hideSheetTitle: true,
            // sheetTitle: context.l10n.positionQrCodeHere,
            // successColor: AppColors.actionPink,
            // borderColor: AppColors.actionPink,
            // borderWidth: 4,
            // cutOutSize: 280,
            // scanLineColor: AppColors.actionPink,
          ),

          if (controller.isLoading)
            Container(
              color: Colors.black.withOpacity(0.7),
              child: const Center(
                child: CircularProgressIndicator(color: AppColors.actionPink),
              ),
            ),
        ],
      ),
    );
  }
}
