import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:locals/shared/components/profile_screen_header.dart';
import 'package:locals/shared/components/profile_segmented_control.dart';
import 'package:locals/shared/theme/app_colors.dart';
import '../controller/filters_controller.dart';
import '../model/filters_model.dart';
import '../repository/filters_repository.dart';
import 'widgets/filters_apply_button.dart';
import 'widgets/filters_categories_section.dart';
import 'widgets/filters_section_label.dart';

class FiltersScreen extends StatelessWidget {
  final FiltersArgs? args;

  const FiltersScreen({super.key, this.args});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => FiltersController(
        FiltersRepositoryImpl(),
        args: args,
      ),
      child: const _FiltersView(),
    );
  }
}

class _FiltersView extends StatelessWidget {
  const _FiltersView();

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<FiltersController>();
    final state = controller.state;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 0),
              child: ProfileScreenHeader(
                title: 'Filters',
                onBack: () => context.pop(),
                trailing: TextButton(
                  onPressed: controller.reset,
                  child: Text(
                    'Reset',
                    style: TextStyle(
                      color: AppColors.actionPink,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.h),
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 20.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FiltersCategoriesSection(
                      selectedIds: state.selectedCategoryIds,
                      onToggle: controller.toggleCategory,
                    ),
                    SizedBox(height: 24.h),
                    const FiltersSectionLabel(label: 'TYPE'),
                    SizedBox(height: 12.h),
                    ProfileSegmentedControl(
                      options: const [
                        ProfileSegmentOption(
                          label: 'Businesses',
                          value: 'businesses',
                        ),
                        ProfileSegmentOption(label: 'Herbs', value: 'herbs'),
                        ProfileSegmentOption(label: 'Both', value: 'both'),
                      ],
                      selectedValue: state.placeType.name,
                      onChanged: (value) => controller.setPlaceType(
                        PlaceTypeFilter.values.byName(value),
                      ),
                    ),
                    SizedBox(height: 24.h),
                    const FiltersSectionLabel(label: 'STATUS'),
                    SizedBox(height: 12.h),
                    ProfileSegmentedControl(
                      options: const [
                        ProfileSegmentOption(
                          label: 'Visited',
                          value: 'visited',
                        ),
                        ProfileSegmentOption(
                          label: 'Unvisited',
                          value: 'unvisited',
                        ),
                        ProfileSegmentOption(label: 'Both', value: 'both'),
                      ],
                      selectedValue: state.visitStatus.name,
                      onChanged: (value) => controller.setVisitStatus(
                        VisitStatusFilter.values.byName(value),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 16.h),
              child: FiltersApplyButton(
                onPressed: () => controller.apply(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
