import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:locals/shared/components/profile_screen_header.dart';
import 'package:locals/shared/theme/app_colors.dart';
import '../controller/saved_places_controller.dart';
import '../repository/saved_places_repository.dart';
import 'widgets/saved_place_card.dart';
import 'package:locals/core/localization/l10n_extensions.dart';

class SavedPlacesScreen extends StatelessWidget {
  const SavedPlacesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SavedPlacesController(SavedPlacesRepositoryImpl()),
      child: const _SavedPlacesView(),
    );
  }
}

class _SavedPlacesView extends StatelessWidget {
  const _SavedPlacesView();

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<SavedPlacesController>();

    if (controller.isLoading) {
      return const Scaffold(
        backgroundColor: AppColors.white,
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 0),
              child: ProfileScreenHeader(
                title: context.l10n.savedPlacesTitle,
                onBack: () => context.pop(),
              ),
            ),
            SizedBox(height: 20.h),
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: RefreshIndicator(
                onRefresh: controller.refresh,
                child: ListView.separated(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 24.h),
                  itemCount: controller.state.places.length,
                  separatorBuilder: (_, __) => SizedBox(height: 16.h),
                  itemBuilder: (context, index) {
                    final place = controller.state.places[index];
                    return SavedPlaceCard(
                      place: place,
                      onTap: () => controller.openPlaceDetails(context, place),
                      onBookmarkTap: () => controller.removePlace(place.id),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
