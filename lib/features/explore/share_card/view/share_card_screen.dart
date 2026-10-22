import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:locals/shared/components/profile_screen_header.dart';
import 'package:locals/shared/theme/app_colors.dart';
import 'package:locals/features/explore/explore/repository/explore_repository.dart';
import '../controller/share_card_controller.dart';
import '../model/share_card_args.dart';
import '../repository/share_card_repository.dart';
import 'widgets/share_card_actions.dart';
import 'widgets/share_card_preview.dart';
import 'widgets/share_card_stats_row.dart';
import 'package:locals/core/localization/l10n_extensions.dart';

class ShareCardScreen extends StatelessWidget {
  final ShareCardArgs? args;

  const ShareCardScreen({super.key, this.args});

  @override
  Widget build(BuildContext context) {
    // Prefer passed args, then router extra, then build from current user
    final resolvedArgs = args ??
        (GoRouterState.of(context).extra as ShareCardArgs?) ??
        ShareCardArgs.fromCurrentUser();

    return ChangeNotifierProvider(
      create: (_) => ShareCardController(
        ShareCardRepositoryImpl(),
        ExploreRepositoryImpl.instance,
        resolvedArgs,
      ),
      child: const _ShareCardView(),
    );
  }
}

class _ShareCardView extends StatelessWidget {
  const _ShareCardView();

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<ShareCardController>();
    final state = controller.state;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 0),
              child: ProfileScreenHeader(
                title: context.l10n.shareCardTitle,
                onBack: () => context.pop(),
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              state.cityLabel,
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 11.sp,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.8,
              ),
            ),
            SizedBox(height: 16.h),
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 24.h),
                child: Column(
                  children: [
                    // ─── Caption field ───────────────────────────────────────
                    TextField(
                      controller: controller.captionController,
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: AppColors.black,
                      ),
                      decoration: InputDecoration(
                        hintText: context.l10n.shareCardCaptionHint,
                        hintStyle: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 14.sp,
                        ),
                        filled: true,
                        fillColor: AppColors.inputBackground,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 14.h,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: BorderSide(
                            color: AppColors.actionPink,
                            width: 1.5,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),

                    // ─── Photo preview ───────────────────────────────────────
                    ShareCardPreview(
                      previewColor: state.previewColor,
                      isConfirmed: state.isConfirmed,
                      imagePath: state.imagePath,
                      onTap: () => controller.capturePhoto(context),
                    ),
                    SizedBox(height: 20.h),

                    // ─── Stats row ───────────────────────────────────────────
                    ShareCardStatsRow(
                      level: state.level,
                      points: state.points,
                      cityPercent: state.cityPercent,
                    ),
                    SizedBox(height: 24.h),

                    // ─── Actions ─────────────────────────────────────────────
                    ShareCardActions(
                      isConfirmed: state.isConfirmed,
                      hasImage: state.imagePath != null,
                      isSaving: state.isSaving,
                      isSaved: state.isSaved,
                      isSubmitting: state.isSubmitting,
                      onRetake: () => controller.retake(context),
                      onConfirm: () => controller.confirm(context),
                      onAddToStory: () async =>
                          controller.addToStory(context),
                      onSaveImage: () => controller.saveImage(context),
                      onDone: () => controller.done(context),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}