import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:locals/core/localization/l10n_extensions.dart';
import 'package:locals/core/localization/notification_l10n.dart';
import 'package:locals/shared/components/profile_screen_header.dart';
import 'package:locals/shared/theme/app_colors.dart';
import '../controller/set_notification_controller.dart';
import '../repository/set_notification_repository.dart';
import 'widgets/notification_setting_tile.dart';

class SetNotificationScreen extends StatelessWidget {
  const SetNotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SetNotificationController(SetNotificationRepositoryImpl()),
      child: const _SetNotificationView(),
    );
  }
}

class _SetNotificationView extends StatelessWidget {
  const _SetNotificationView();

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<SetNotificationController>();
    final l10n = context.l10n;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProfileScreenHeader(
                title: l10n.notificationsTitle,
                onBack: () => context.pop(),
              ),
              SizedBox(height: 24.h),
              ...controller.state.settings.map((setting) {
                return Padding(
                  padding: EdgeInsets.only(bottom: 12.h),
                  child: NotificationSettingTile(
                    title: NotificationL10n.title(l10n, setting.id),
                    subtitle: NotificationL10n.subtitle(l10n, setting.id),
                    enabled: setting.enabled,
                    onChanged: (value) =>
                        controller.toggleSetting(setting.id, value),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
