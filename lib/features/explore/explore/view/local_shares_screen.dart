import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:locals/core/localization/l10n_extensions.dart';
import 'package:locals/features/explore/explore/view/widgets/local_share_item.dart';
import 'package:locals/shared/components/profile_screen_header.dart';
import 'package:locals/shared/theme/app_colors.dart';
import 'package:provider/provider.dart';
import '../controller/local_shares_controller.dart';

class LocalSharesScreen extends StatelessWidget {
  const LocalSharesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LocalSharesController(),
      child: const _LocalSharesView(),
    );
  }
}

class _LocalSharesView extends StatelessWidget {
  const _LocalSharesView();

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<LocalSharesController>();

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 0),
              child: ProfileScreenHeader(
                title: context.l10n.localShares,
                onBack: () => context.pop(),
              ),
            ),
            SizedBox(height: 20.h),
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: GridView.builder(
                padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 24.h),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12.w,
                  mainAxisSpacing: 12.h,
                  childAspectRatio: 0.95,
                ),
                itemCount: controller.shares.length,
                itemBuilder: (context, index) {
                  final share = controller.shares[index];
                  return LocalShareItem(
                    share: share,
                    onTap: () =>
                        controller.openLocalShareDetail(context, share),
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
