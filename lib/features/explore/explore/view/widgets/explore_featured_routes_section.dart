import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../model/explore_model.dart';
import 'explore_route_card.dart';
import 'explore_section_header.dart';

class ExploreFeaturedRoutesSection extends StatelessWidget {
  final ExploreFeaturedRoute route;
  final VoidCallback onAllEvents;
  final VoidCallback? onRouteTap;

  const ExploreFeaturedRoutesSection({
    super.key,
    required this.route,
    required this.onAllEvents,
    this.onRouteTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ExploreSectionHeader(
          icon: Icons.explore_outlined,
          title: 'FEATURED ROUTES',
          actionLabel: 'All events',
          onAction: onAllEvents,
        ),
        SizedBox(height: 12.h),
        ExploreRouteCard(route: route, onTap: onRouteTap),
      ],
    );
  }
}
