import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:locals/shared/components/profile_screen_header.dart';
import 'package:locals/shared/theme/app_colors.dart';
import '../controller/settings_controller.dart';
import '../repository/settings_repository.dart';
import 'widgets/settings_section_card.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SettingsController(SettingsRepositoryImpl()),
      child: const _SettingsView(),
    );
  }
}

class _SettingsView extends StatelessWidget {
  const _SettingsView();

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<SettingsController>();

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 0),
              child: ProfileScreenHeader(
                title: 'Settings',
                onBack: () => context.pop(),
              ),
            ),
            SizedBox(height: 20.h),
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: ListView.separated(
                padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 24.h),
                itemCount: controller.state.sections.length,
                separatorBuilder: (_, __) => SizedBox(height: 24.h),
                itemBuilder: (context, index) {
                  final section = controller.state.sections[index];
                  return SettingsSectionCard(
                    section: section,
                    onItemTap: (id) => controller.handleItemTap(context, id),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
