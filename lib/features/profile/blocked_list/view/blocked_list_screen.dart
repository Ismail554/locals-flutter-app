import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:locals/shared/components/profile_screen_header.dart';
import 'package:locals/shared/theme/app_colors.dart';
import '../controller/blocked_list_controller.dart';
import '../repository/blocked_list_repository.dart';
import 'widgets/blocked_user_item.dart';
import 'package:locals/core/localization/l10n_extensions.dart';

class BlockedListScreen extends StatelessWidget {
  const BlockedListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => BlockedListController(BlockedListRepositoryImpl()),
      child: const _BlockedListView(),
    );
  }
}

class _BlockedListView extends StatelessWidget {
  const _BlockedListView();

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<BlockedListController>();

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 0),
              child: ProfileScreenHeader(
                title: context.l10n.blockedListTitle,
                onBack: () => context.pop(),
              ),
            ),
            SizedBox(height: 20.h),
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: ListView.separated(
                padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 24.h),
                itemCount: controller.state.users.length,
                separatorBuilder: (_, __) => SizedBox(height: 10.h),
                itemBuilder: (context, index) {
                  final user = controller.state.users[index];
                  return BlockedUserItem(
                    user: user,
                    onUnblock: () => controller.unblock(user.id),
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
