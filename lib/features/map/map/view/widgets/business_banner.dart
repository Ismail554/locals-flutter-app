import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locals/core/localization/l10n_extensions.dart';
import 'package:locals/shared/theme/app_colors.dart';

enum BannerType { businessOfTheMonth, sponsored }

class BusinessBanner extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String? imageUrl;
  final BannerType type;
  final VoidCallback onTap;
  final VoidCallback? onClose;

  const BusinessBanner({
    super.key,
    required this.title,
    this.subtitle,
    this.imageUrl,
    this.type = BannerType.businessOfTheMonth,
    required this.onTap,
    this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16.r),
        child: Ink(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Stack(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Left Image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(24.r),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 72.w,
                        height: 72.w,
                        decoration: BoxDecoration(
                          color: const Color(0xFFD4C4B0),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: imageUrl != null
                            ? Image.asset(imageUrl!, fit: BoxFit.cover)
                            : const Icon(
                                Icons.storefront,
                                color: Colors.white70,
                                size: 32,
                              ),
                      ),
                    ),
                  ),
                  // Content Area
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(12.w, 12.h, 12.w, 12.h),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Badge
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 10.w,
                                  vertical: 4.h,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.actionPink,
                                  borderRadius: BorderRadius.circular(20.r),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      type == BannerType.businessOfTheMonth
                                          ? Icons.emoji_events_rounded
                                          : Icons.workspace_premium_outlined,
                                      color: Colors.white,
                                      size: 16.sp,
                                    ),
                                    SizedBox(width: 4.w),
                                    Text(
                                      type == BannerType.businessOfTheMonth
                                          ? context.l10n.busniessOfTheMonth
                                          : context.l10n.sponsored,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              SizedBox(height: 8.h),

                              // Title
                              Text(
                                title,
                                style: TextStyle(
                                  fontSize: 17.sp,
                                  fontWeight: FontWeight.w700,
                                  height: 1.2,
                                ),
                              ),

                              if (subtitle != null) ...[
                                SizedBox(height: 4.h),
                                Text(
                                  subtitle!,
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ],
                            ],
                          ),
                          Spacer(),
                          Padding(
                            padding: EdgeInsets.only(top: 12.h, right: 12.w),
                            child: Text(
                              context.l10n.learnMore,
                              style: TextStyle(
                                color: AppColors.actionPink,
                                fontSize: 13.5.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              // Close Button (Top Right)
              if (onClose != null)
                Positioned(
                  top: 8.h,
                  right: 8.w,
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: onClose,
                      borderRadius: BorderRadius.circular(20.r),
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        child: Icon(
                          Icons.close,
                          size: 20.sp,
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
