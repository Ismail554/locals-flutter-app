import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:locals/shared/components/legal_document_body.dart';
import 'package:locals/shared/components/profile_screen_header.dart';
import 'package:locals/shared/theme/app_colors.dart';
import '../controller/privacy_policy_controller.dart';
import '../repository/privacy_policy_repository.dart';
import 'package:locals/core/localization/l10n_extensions.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) =>
          PrivacyPolicyController(PrivacyPolicyRepositoryImpl())..load(),
      child: const _PrivacyPolicyView(),
    );
  }
}

class _PrivacyPolicyView extends StatelessWidget {
  const _PrivacyPolicyView();

  @override
  Widget build(BuildContext context) {
    final state = context.watch<PrivacyPolicyController>().state;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 0),
              child: ProfileScreenHeader(
                title: context.l10n.privacyPolicyTitle,
                onBack: () => context.pop(),
              ),
            ),
            SizedBox(height: 16.h),
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: LegalDocumentBody(
                lastUpdated: state.lastUpdated,
                sections: state.sections,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
