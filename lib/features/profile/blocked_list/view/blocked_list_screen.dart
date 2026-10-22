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
    final state = controller.state;

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
              child: state.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : state.errorMessage != null && state.users.isEmpty
                      ? Center(
                          child: Text(
                            state.errorMessage!,
                            style: TextStyle(
                              color: AppColors.levelGrey,
                              fontSize: 14.sp,
                            ),
                          ),
                        )
                      : state.users.isEmpty
                          ? Center(
                              child: Text(
                                context.l10n.blockedListTitle,
                                style: TextStyle(
                                  color: AppColors.levelGrey,
                                  fontSize: 14.sp,
                                ),
                              ),
                            )
                          : RefreshIndicator(
                              onRefresh: controller.refresh,
                              child: ListView.separated(
                                padding:
                                    EdgeInsets.fromLTRB(20.w, 0, 20.w, 24.h),
                                itemCount: state.users.length,
                                separatorBuilder: (_, __) =>
                                    SizedBox(height: 10.h),
                                itemBuilder: (context, index) {
                                  final user = state.users[index];
                                  return BlockedUserItem(
                                    user: user,
                                    onUnblock: () =>
                                        controller.unblock(user.id),
                                  );
                                },
                              ),
                            ),
            ),
          ],
        ),
      ),
    );
  }
}