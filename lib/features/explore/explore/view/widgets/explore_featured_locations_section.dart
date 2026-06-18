import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../model/explore_model.dart';
import 'explore_location_card.dart';
import 'explore_section_header.dart';
import 'package:locals/core/localization/l10n_extensions.dart';

class ExploreFeaturedLocationsSection extends StatelessWidget {
  final List<ExploreFeaturedLocation> locations;
  final VoidCallback onSeeAll;
  final void Function(String locationId)? onLocationTap;

  const ExploreFeaturedLocationsSection({
    super.key,
    required this.locations,
    required this.onSeeAll,
    this.onLocationTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ExploreSectionHeader(
          icon: Icons.photo_outlined,
          title: context.l10n.exploreFeaturedLocations,
          actionLabel: context.l10n.commonSeeAll,
          onAction: onSeeAll,
        ),
        SizedBox(height: 12.h),
        SizedBox(
          height: 176.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: locations.length,
            separatorBuilder: (_, __) => SizedBox(width: 12.w),
            itemBuilder: (context, index) {
              final location = locations[index];
              return GestureDetector(
                onTap: () => onLocationTap?.call(location.id),
                child: ExploreLocationCard(location: location),
              );
            },
          ),
        ),
      ],
    );
  }
}
