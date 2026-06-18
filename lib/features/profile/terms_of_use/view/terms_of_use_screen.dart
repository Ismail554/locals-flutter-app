import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:locals/shared/components/legal_document_body.dart';
import 'package:locals/shared/components/profile_screen_header.dart';
import 'package:locals/shared/theme/app_colors.dart';
import '../controller/terms_of_use_controller.dart';
import '../repository/terms_of_use_repository.dart';
import 'package:locals/core/localization/l10n_extensions.dart';

class TermsOfUseScreen extends StatelessWidget {
  const TermsOfUseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TermsOfUseController(TermsOfUseRepositoryImpl())..load(),
      child: const _TermsOfUseView(),
    );
  }
}

class _TermsOfUseView extends StatelessWidget {
  const _TermsOfUseView();

  @override
  Widget build(BuildContext context) {
    final state = context.watch<TermsOfUseController>().state;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 0),
              child: ProfileScreenHeader(
                title: context.l10n.termsOfUseTitle,
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
