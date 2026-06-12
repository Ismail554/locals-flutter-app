import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:locals/shared/components/profile_screen_header.dart';
import 'package:locals/shared/theme/app_colors.dart';
import '../controller/notification_controller.dart';
import '../repository/notification_repository.dart';
import 'widgets/notification_card.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => NotificationController(NotificationRepositoryImpl()),
      child: const _NotificationView(),
    );
  }
}

class _NotificationView extends StatelessWidget {
  const _NotificationView();

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<NotificationController>();

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 0),
              child: ProfileScreenHeader(
                title: 'Notifications',
                onBack: () => context.pop(),
              ),
            ),
            SizedBox(height: 16.h),
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: ListView.separated(
                padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 24.h),
                itemCount: controller.state.items.length,
                separatorBuilder: (_, __) => SizedBox(height: 10.h),
                itemBuilder: (context, index) {
                  final item = controller.state.items[index];
                  return NotificationCard(
                    item: item,
                    onTap: () => controller.markRead(item.id),
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
