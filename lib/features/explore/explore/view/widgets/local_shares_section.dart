import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locals/core/localization/l10n_extensions.dart';
import 'package:locals/features/explore/explore/model/explore_model.dart';
import 'package:locals/features/explore/explore/view/widgets/explore_section_header.dart';
import 'package:locals/shared/theme/app_colors.dart';

class LocalSharesSection extends StatelessWidget {
  final List<ExploreLocalShare> shares;
  final ValueChanged<ExploreLocalShare>? onPhotoTap;
  final VoidCallback onSeeAll;

  const LocalSharesSection({
    super.key,
    required this.shares,
    this.onPhotoTap,
    required this.onSeeAll,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ExploreSectionHeader(
          icon: Icons.camera_alt_outlined,
          title: context.l10n.localShares,
          actionLabel: context.l10n.commonSeeAll,
          onAction: onSeeAll,
        ),
        SizedBox(height: 12.h),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 8.w,
            mainAxisSpacing: 8.h,
            childAspectRatio: 1,
          ),
          itemCount: shares.length,
          itemBuilder: (context, index) {
            final share = shares[index];

            return Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onPhotoTap != null ? () => onPhotoTap!(share) : null,
                borderRadius: BorderRadius.circular(12.r),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.r),
                  child: Ink(
                    decoration: BoxDecoration(
                      color: share.imageColor,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: share.imageUrl != null
                        ? Image.network(
                            share.imageUrl!,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                            loadingBuilder: (_, child, progress) {
                              if (progress == null) return child;
                              return _placeholderIcon();
                            },
                            errorBuilder: (_, __, ___) => _placeholderIcon(),
                          )
                        : _placeholderIcon(),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _placeholderIcon() {
    return Center(
      child: Icon(
        Icons.image_outlined,
        color: Colors.white.withValues(alpha: 0.6),
        size: 32.sp,
      ),
    );
  }
}