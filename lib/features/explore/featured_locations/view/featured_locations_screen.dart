import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:locals/shared/components/profile_screen_header.dart';
import 'package:locals/shared/theme/app_colors.dart';
import '../controller/featured_locations_controller.dart';
import '../repository/featured_locations_repository.dart';
import 'widgets/featured_location_card.dart';

class FeaturedLocationsScreen extends StatelessWidget {
  const FeaturedLocationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => FeaturedLocationsController(
        FeaturedLocationsRepositoryImpl(),
      ),
      child: const _FeaturedLocationsView(),
    );
  }
}

class _FeaturedLocationsView extends StatelessWidget {
  const _FeaturedLocationsView();

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<FeaturedLocationsController>();
    final locations = controller.state.locations;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 0),
              child: ProfileScreenHeader(
                title: 'Featured locations',
                onBack: () => context.pop(),
              ),
            ),
            SizedBox(height: 20.h),
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: ListView.separated(
                padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 24.h),
                itemCount: locations.length,
                separatorBuilder: (_, __) => SizedBox(height: 16.h),
                itemBuilder: (context, index) {
                  final location = locations[index];
                  return FeaturedLocationCard(
                    location: location,
                    onTap: () =>
                        controller.openLocation(context, location.id),
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
