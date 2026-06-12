import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../model/explore_model.dart';
import 'explore_new_local_item.dart';
import 'explore_section_header.dart';

class ExploreNewLocalsSection extends StatelessWidget {
  final List<ExploreNewLocal> locals;

  const ExploreNewLocalsSection({super.key, required this.locals});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ExploreSectionHeader(
          icon: Icons.explore_outlined,
          title: 'NEW LOCALS',
        ),
        SizedBox(height: 12.h),
        Column(
          children: [
            for (var i = 0; i < locals.length; i++) ...[
              ExploreNewLocalItem(local: locals[i]),
              if (i < locals.length - 1) SizedBox(height: 10.h),
            ],
          ],
        ),
      ],
    );
  }
}
