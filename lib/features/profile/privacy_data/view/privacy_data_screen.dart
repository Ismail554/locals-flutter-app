import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:locals/shared/components/profile_screen_header.dart';
import 'package:locals/shared/theme/app_colors.dart';
import '../controller/privacy_data_controller.dart';
import '../repository/privacy_data_repository.dart';
import 'widgets/privacy_delete_account_button.dart';
import 'widgets/privacy_encryption_banner.dart';
import 'widgets/privacy_legal_links.dart';

class PrivacyDataScreen extends StatelessWidget {
  const PrivacyDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) =>
          PrivacyDataController(PrivacyDataRepositoryImpl())..load(),
      child: const _PrivacyDataView(),
    );
  }
}

class _PrivacyDataView extends StatelessWidget {
  const _PrivacyDataView();

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<PrivacyDataController>();
    final state = controller.state;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 0),
              child: ProfileScreenHeader(
                title: 'Privacy & Data',
                onBack: () => context.pop(),
              ),
            ),
            SizedBox(height: 24.h),
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  children: [
                    PrivacyEncryptionBanner(
                      title: state.encryptionTitle,
                      subtitle: state.encryptionSubtitle,
                    ),
                    SizedBox(height: 16.h),
                    PrivacyDeleteAccountButton(
                      onTap: () => controller.confirmDeleteAccount(context),
                    ),
                    const Spacer(),
                    PrivacyLegalLinks(
                      onPrivacyPolicy: () =>
                          controller.openPrivacyPolicy(context),
                      onTermsOfUse: () => controller.openTermsOfUse(context),
                    ),
                    SizedBox(height: 32.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
