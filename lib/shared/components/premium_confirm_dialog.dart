import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locals/shared/theme/app_colors.dart';

enum PremiumConfirmStyle { standard, destructive }

class PremiumConfirmDialog {
  PremiumConfirmDialog._();

  static Future<bool> show(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String message,
    required String confirmLabel,
    String cancelLabel = 'Cancel',
    PremiumConfirmStyle style = PremiumConfirmStyle.standard,
  }) async {
    final result = await showGeneralDialog<bool>(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Dismiss',
      barrierColor: AppColors.black.withValues(alpha: 0.45),
      transitionDuration: const Duration(milliseconds: 280),
      pageBuilder: (context, animation, secondaryAnimation) {
        return Center(
          child: _PremiumConfirmDialogBody(
            icon: icon,
            title: title,
            message: message,
            confirmLabel: confirmLabel,
            cancelLabel: cancelLabel,
            style: style,
          ),
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        final curved = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutCubic,
          reverseCurve: Curves.easeInCubic,
        );

        return FadeTransition(
          opacity: curved,
          child: ScaleTransition(
            scale: Tween<double>(begin: 0.9, end: 1).animate(curved),
            child: child,
          ),
        );
      },
    );

    return result ?? false;
  }

  static Future<bool> showLogout(BuildContext context) {
    return show(
      context,
      icon: Icons.logout_rounded,
      title: 'Log out?',
      message:
          'You will need to sign in again to access your profile, missions, and saved places.',
      confirmLabel: 'Log out',
      style: PremiumConfirmStyle.standard,
    );
  }

  static Future<bool> showDeleteAccount(BuildContext context) {
    return show(
      context,
      icon: Icons.delete_forever_rounded,
      title: 'Delete account?',
      message:
          'This permanently removes your profile, progress, and saved data. This action cannot be undone.',
      confirmLabel: 'Delete account',
      style: PremiumConfirmStyle.destructive,
    );
  }
}

class _PremiumConfirmDialogBody extends StatefulWidget {
  final IconData icon;
  final String title;
  final String message;
  final String confirmLabel;
  final String cancelLabel;
  final PremiumConfirmStyle style;

  const _PremiumConfirmDialogBody({
    required this.icon,
    required this.title,
    required this.message,
    required this.confirmLabel,
    required this.cancelLabel,
    required this.style,
  });

  @override
  State<_PremiumConfirmDialogBody> createState() =>
      _PremiumConfirmDialogBodyState();
}

class _PremiumConfirmDialogBodyState extends State<_PremiumConfirmDialogBody>
    with SingleTickerProviderStateMixin {
  late final AnimationController _iconController;
  late final Animation<double> _iconScale;
  late final Animation<double> _iconFade;

  @override
  void initState() {
    super.initState();
    _iconController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 520),
    );
    _iconScale = Tween<double>(begin: 0.72, end: 1).animate(
      CurvedAnimation(parent: _iconController, curve: Curves.easeOutBack),
    );
    _iconFade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _iconController,
        curve: const Interval(0, 0.55, curve: Curves.easeOut),
      ),
    );
    _iconController.forward();
  }

  @override
  void dispose() {
    _iconController.dispose();
    super.dispose();
  }

  bool get _isDestructive => widget.style == PremiumConfirmStyle.destructive;

  Color get _iconBackgroundColor => _isDestructive
      ? AppColors.actionPink.withValues(alpha: 0.14)
      : AppColors.profileLevelCard.withValues(alpha: 0.08);

  Color get _iconColor =>
      _isDestructive ? AppColors.actionPink : AppColors.profileLevelCard;

  Color get _confirmColor =>
      _isDestructive ? AppColors.actionPink : AppColors.profileLevelCard;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        width: 320.w,
        margin: EdgeInsets.symmetric(horizontal: 24.w),
        padding: EdgeInsets.fromLTRB(24.w, 28.h, 24.w, 24.h),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(28.r),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withValues(alpha: 0.12),
              blurRadius: 32,
              offset: const Offset(0, 16),
            ),
            BoxShadow(
              color: AppColors.actionPink.withValues(alpha: 0.08),
              blurRadius: 24,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FadeTransition(
              opacity: _iconFade,
              child: ScaleTransition(
                scale: _iconScale,
                child: Container(
                  width: 72.w,
                  height: 72.w,
                  decoration: BoxDecoration(
                    color: _iconBackgroundColor,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: _iconColor.withValues(alpha: 0.12),
                      width: 1.5,
                    ),
                  ),
                  child: Icon(
                    widget.icon,
                    color: _iconColor,
                    size: 34.sp,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              widget.title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.black,
                fontSize: 22.sp,
                fontWeight: FontWeight.w700,
                height: 1.2,
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              widget.message,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.levelGrey,
                fontSize: 14.sp,
                height: 1.45,
              ),
            ),
            SizedBox(height: 28.h),
            Row(
              children: [
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.black,
                      side: BorderSide(
                        color: AppColors.borderGray.withValues(alpha: 0.9),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28.r),
                      ),
                    ),
                    child: Text(
                      widget.cancelLabel,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: FilledButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    style: FilledButton.styleFrom(
                      backgroundColor: _confirmColor,
                      foregroundColor: AppColors.white,
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28.r),
                      ),
                    ),
                    child: Text(
                      widget.confirmLabel,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
