import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locals/core/localization/l10n_extensions.dart';
import 'package:locals/shared/theme/app_colors.dart';

class RestaurantInfoRows extends StatefulWidget {
  final String address;
  final String hours;
  final String instagramHandle;

  const RestaurantInfoRows({
    super.key,
    required this.address,
    required this.hours,
    required this.instagramHandle,
  });

  @override
  @override
  State<RestaurantInfoRows> createState() => _RestaurantInfoRowsState();
}

class _RestaurantInfoRowsState extends State<RestaurantInfoRows> {
  bool _hoursExpanded = false;

  List<String> _hoursLines() {
    final lines = widget.hours
        .split(
          RegExp(
            r'\s*(?=(?:Monday|Tuesday|Wednesday|Thursday|Friday|Saturday|Sunday)\s*:)',
            caseSensitive: false,
          ),
        )
        .where((line) => line.trim().isNotEmpty)
        .toList();
    return lines.isEmpty ? [widget.hours] : lines;
  }

  @override
  Widget build(BuildContext context) {
    final hoursLines = _hoursLines();

    return Column(
      children: [
        _InfoRow(icon: Icons.location_on_outlined, text: widget.address),
        SizedBox(height: 12.h),
        _ScheduleRow(
          lines: hoursLines,
          isExpanded: _hoursExpanded,
          onToggle: hoursLines.length > 1
              ? () => setState(() => _hoursExpanded = !_hoursExpanded)
              : null,
        ),
        SizedBox(height: 12.h),
        _InfoRow(icon: Icons.camera_alt_outlined, text: widget.instagramHandle),
      ],
    );
  }
}

class _ScheduleRow extends StatelessWidget {
  final List<String> lines;
  final bool isExpanded;
  final VoidCallback? onToggle;

  const _ScheduleRow({
    required this.lines,
    required this.isExpanded,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    final visibleLines = isExpanded ? lines : lines.take(1).toList();
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          Icons.access_time_outlined,
          color: AppColors.levelGrey,
          size: 20.sp,
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final line in visibleLines)
                Padding(
                  padding: EdgeInsets.only(bottom: 4.h),
                  child: Text(
                    line.trim(),
                    style: TextStyle(
                      color: AppColors.black,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              if (onToggle != null)
                GestureDetector(
                  onTap: onToggle,
                  child: Text(
                    isExpanded
                        ? context.l10n.commonShowLess
                        : context.l10n.commonShowMore,
                    style: TextStyle(
                      color: AppColors.actionPink,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const _InfoRow({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: AppColors.levelGrey, size: 20.sp),
        SizedBox(width: 12.w),
        Flexible(
          flex: 1,
          fit: FlexFit.tight,
          child: Text(
            text,
            style: TextStyle(
              color: AppColors.black,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
