import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locals/features/explore/explore/model/explore_model.dart';
import 'package:locals/features/explore/explore/view/widgets/local_share_item.dart';
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
      appBar: AppBar(
        title: const Text('Local Shares'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 0,
        backgroundColor: AppColors.white,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: GridView.builder(
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
              onTap: () => controller.openLocalShareDetail(context, share),
            );
          },
        ),
      ),
    );
  }
}
