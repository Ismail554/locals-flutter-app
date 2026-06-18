import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:locals/core/localization/l10n_extensions.dart';
import 'package:locals/core/localization/privacy_l10n.dart';
import 'package:locals/shared/components/profile_screen_header.dart';
import 'package:locals/shared/components/profile_segmented_control.dart';
import 'package:locals/shared/theme/app_colors.dart';
import '../controller/privacy_controller.dart';
import '../repository/privacy_repository.dart';
import 'widgets/privacy_setting_row.dart';

class PrivacyScreen extends StatelessWidget {
  const PrivacyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PrivacyController(PrivacyRepositoryImpl()),
      child: const _PrivacyView(),
    );
  }
}

class _PrivacyView extends StatelessWidget {
  const _PrivacyView();

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<PrivacyController>();
    final state = controller.state;
    final l10n = context.l10n;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 0),
              child: ProfileScreenHeader(
                title: l10n.privacyTitle,
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
                  PrivacySettingRow(
                    label: PrivacyL10n.sectionLabel(l10n, state.profileVisibility),
                    options: state.profileVisibility.options
                        .map((o) => ProfileSegmentOption(
                              label: PrivacyL10n.optionLabel(l10n, o.id),
                              value: o.id,
                            ))
                        .toList(),
                    selectedValue:
                        controller.selectedId(state.profileVisibility),
                    onChanged: controller.updateProfileVisibility,
                  ),
                  SizedBox(height: 24.h),
                  PrivacySettingRow(
                    label: PrivacyL10n.sectionLabel(l10n, state.photoVisibility),
                    options: state.photoVisibility.options
                        .map((o) => ProfileSegmentOption(
                              label: PrivacyL10n.optionLabel(l10n, o.id),
                              value: o.id,
                            ))
                        .toList(),
                    selectedValue: controller.selectedId(state.photoVisibility),
                    onChanged: controller.updatePhotoVisibility,
                  ),
                  SizedBox(height: 24.h),
                  PrivacySettingRow(
                    label: PrivacyL10n.sectionLabel(l10n, state.locationPermission),
                    options: state.locationPermission.options
                        .map((o) => ProfileSegmentOption(
                              label: PrivacyL10n.optionLabel(l10n, o.id),
                              value: o.id,
                            ))
                        .toList(),
                    selectedValue:
                        controller.selectedId(state.locationPermission),
                    onChanged: controller.updateLocationPermission,
                  ),
                  SizedBox(height: 24.h),
                  PrivacySettingRow(
                    label:
                        PrivacyL10n.sectionLabel(l10n, state.leaderboardVisibility),
                    options: state.leaderboardVisibility.options
                        .map((o) => ProfileSegmentOption(
                              label: PrivacyL10n.optionLabel(l10n, o.id),
                              value: o.id,
                            ))
                        .toList(),
                    selectedValue:
                        controller.selectedId(state.leaderboardVisibility),
                    onChanged: controller.updateLeaderboardVisibility,
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
