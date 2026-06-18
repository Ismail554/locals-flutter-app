import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:locals/shared/components/primary_button.dart';
import 'package:locals/shared/components/profile_screen_header.dart';
import 'package:locals/shared/theme/app_colors.dart';
import '../controller/help_support_controller.dart';
import '../repository/help_support_repository.dart';
import 'widgets/help_email_field.dart';
import 'package:locals/core/localization/l10n_extensions.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) =>
          HelpSupportController(HelpSupportRepositoryImpl())..load(),
      child: const _HelpSupportView(),
    );
  }
}

class _HelpSupportView extends StatelessWidget {
  const _HelpSupportView();

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<HelpSupportController>();
    final state = controller.state;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 0),
              child: ProfileScreenHeader(
                title: context.l10n.helpSupportTitle,
                onBack: () => context.pop(),
              ),
            ),
            SizedBox(height: 24.h),
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: ListView(
                padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 24.h),
                children: [
                  HelpEmailField(
                    label: context.l10n.helpSubjectLabel,
                    controller: controller.subjectController,
                  ),
                  SizedBox(height: 16.h),
                  HelpEmailField(
                    label: context.l10n.helpMessageLabel,
                    controller: controller.messageController,
                    maxLines: 8,
                    hint: context.l10n.helpMessageHint,
                  ),
                  SizedBox(height: 24.h),
                  PrimaryButton(
                    label: controller.isSending ? context.l10n.helpSending : context.l10n.helpSend,
                    onPressed: controller.isSending
                        ? () {}
                        : () => controller.sendEmail(context),
                  ),
                  SizedBox(height: 24.h),
                  Center(
                    child: Text(
                      'Version ${state.appVersion}',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 13.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
