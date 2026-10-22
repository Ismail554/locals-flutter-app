import 'package:ai_barcode_scanner/ai_barcode_scanner.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:locals/shared/theme/app_colors.dart';
import 'package:provider/provider.dart';

import '../controller/qr_discount_controller.dart';
import '../model/qr_discount_result.dart';
import '../repository/qr_discount_repository.dart';

/// QR scanner reached from the Settings page, used to claim place
/// discounts. Unlike the old check-in flow, this needs only the QR
/// token — no device location and no place id.
class QRScanScreen extends StatelessWidget {
  const QRScanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => QRDiscountController(QRDiscountRepositoryImpl()),
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

    final controller = context.read<QRDiscountController>();

    try {
      final result = await controller.repo.claimDiscount(qrToken: value);

      if (!mounted) return;

      // Close the scanner and return the discount claim result to
      // whoever pushed this screen (Settings).
      Navigator.pop(context, result);
    } catch (e) {
      debugPrint("QR discount scan error: $e");

      if (!mounted) return;

      Navigator.pop(
        context,
        const QRDiscountResult(
          success: false,
          message: 'Failed to scan QR code. Please try again.',
        ),
      );
    } finally {
      isProcessing = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<QRDiscountController>();

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Scan for Discount'),
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: Stack(
        children: [
          AiBarcodeScanner(onDetect: _handleScan),

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