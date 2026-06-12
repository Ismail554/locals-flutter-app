import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:locals/features/map/map/model/map_model.dart';
import 'package:locals/features/map/map/view/widgets/map_background.dart';
import 'package:locals/features/map/map/view/widgets/map_pin_marker.dart';
import 'package:locals/shared/components/profile_screen_header.dart';
import 'package:locals/shared/components/profile_segmented_control.dart';
import 'package:locals/shared/theme/app_colors.dart';
import '../controller/my_map_controller.dart';
import '../model/my_map_model.dart';
import '../repository/my_map_repository.dart';
import 'widgets/my_map_legend.dart';

class MyMapScreen extends StatelessWidget {
  const MyMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MyMapController(MyMapRepositoryImpl()),
      child: const _MyMapView(),
    );
  }
}

class _MyMapView extends StatelessWidget {
  const _MyMapView();

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<MyMapController>();
    final state = controller.state;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 0),
              child: ProfileScreenHeader(
                title: 'My map',
                onBack: () => context.pop(),
              ),
            ),
            SizedBox(height: 16.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: ProfileSegmentedControl(
                options: [
                  ProfileSegmentOption(
                    label: 'All',
                    value: MyMapFilter.all.name,
                  ),
                  ProfileSegmentOption(
                    label: 'visited · ${state.visitedCount}',
                    value: MyMapFilter.visited.name,
                  ),
                  ProfileSegmentOption(
                    label: 'Unvisited · ${state.unvisitedCount}',
                    value: MyMapFilter.unvisited.name,
                  ),
                ],
                selectedValue: state.selectedFilter.name,
                onChanged: (value) =>
                    controller.selectFilter(MyMapFilter.values.byName(value)),
              ),
            ),
            SizedBox(height: 12.h),
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Padding(
                padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 20.h),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.r),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final mapWidth = constraints.maxWidth;
                      final mapHeight = constraints.maxHeight;

                      return Stack(
                        fit: StackFit.expand,
                        children: [
                          const MapBackground(),
                          Positioned(
                            top: 12.h,
                            left: 0,
                            right: 0,
                            child: const Center(child: MyMapLegend()),
                          ),
                          ...state.filteredPins.map((pin) {
                            final type = pin.visited && pin.type != MapPinType.red
                                ? MapPinType.red
                                : pin.type;
                            return Positioned(
                              left: pin.x * mapWidth - 18.w,
                              top: pin.y * mapHeight - 24.h,
                              child: MapPinMarker(type: type),
                            );
                          }),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
