import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locals/features/explore/events_progress_map/model/events_progress_map_model.dart';
import 'package:locals/shared/components/map/scrollable_map_canvas.dart';
import 'package:locals/shared/theme/app_colors.dart';
import 'event_progress_stop_card.dart';

class EventsProgressBottomPanel extends StatelessWidget {
  final EventsProgressMapModel state;
  final VoidCallback onCheckIn;

  const EventsProgressBottomPanel({
    super.key,
    required this.state,
    required this.onCheckIn,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.08),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 16.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Progress',
                style: TextStyle(
                  color: AppColors.black,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Spacer(),
              Text(
                state.progressLabel,
                style: TextStyle(
                  color: AppColors.levelGrey,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          ClipRRect(
            borderRadius: BorderRadius.circular(4.r),
            child: LinearProgressIndicator(
              value: state.progress,
              minHeight: 6.h,
              backgroundColor: AppColors.chipUnselected,
              color: AppColors.actionPink,
            ),
          ),
          SizedBox(height: 16.h),
          SizedBox(
            height: 130.h,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: state.stops.length,
              separatorBuilder: (_, __) => SizedBox(width: 10.w),
              itemBuilder: (context, index) {
                return EventProgressStopCard(stop: state.stops[index]);
              },
            ),
          ),
          SizedBox(height: 16.h),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: state.canCheckIn ? onCheckIn : null,
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.actionPink,
                disabledBackgroundColor:
                    AppColors.actionPink.withValues(alpha: 0.4),
                foregroundColor: AppColors.white,
                padding: EdgeInsets.symmetric(vertical: 16.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28.r),
                ),
              ),
              child: Text(
                state.canCheckIn ? 'Check in next stop' : 'Route complete',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class EventsProgressMapView extends StatefulWidget {
  final EventsProgressMapModel state;

  const EventsProgressMapView({super.key, required this.state});

  @override
  State<EventsProgressMapView> createState() => _EventsProgressMapViewState();
}

class _EventsProgressMapViewState extends State<EventsProgressMapView> {
  String? _selectedPinId;

  void _onPinTap(String pinId) {
    setState(() {
      _selectedPinId = _selectedPinId == pinId ? null : pinId;
    });
  }

  void _clearSelectedPin() {
    if (_selectedPinId == null) return;
    setState(() => _selectedPinId = null);
  }

  @override
  Widget build(BuildContext context) {
    return ScrollableMapCanvas(
      pins: widget.state.pins,
      selectedPinId: _selectedPinId,
      onPinTap: _onPinTap,
      onBackgroundTap: _clearSelectedPin,
    );
  }
}
