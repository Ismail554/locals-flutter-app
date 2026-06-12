import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locals/shared/theme/app_colors.dart';
import '../../model/map_model.dart';

class MapPinMarker extends StatelessWidget {
  final MapPinType type;

  const MapPinMarker({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    final (Color bg, Widget inner) = switch (type) {
      MapPinType.red => (AppColors.actionPink, _dot()),
      MapPinType.greyStar => (AppColors.pinGrey, _star()),
      MapPinType.greyDot => (AppColors.pinGrey, _dot()),
      MapPinType.darkStar => (AppColors.pinDark, _star()),
    };

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 36.w,
          height: 36.w,
          decoration: BoxDecoration(
            color: bg,
            shape: BoxShape.circle,
            boxShadow: const [
              BoxShadow(
                color: AppColors.cardShadow,
                blurRadius: 6,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Center(child: inner),
        ),
        Container(
          width: 10.w,
          height: 6.h,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(2.r),
            boxShadow: const [
              BoxShadow(
                color: AppColors.cardShadow,
                blurRadius: 4,
                offset: Offset(0, 1),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _dot() {
    return Container(
      width: 8.w,
      height: 8.w,
      decoration: const BoxDecoration(
        color: AppColors.white,
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _star() {
    return Icon(Icons.star, color: AppColors.white, size: 16.sp);
  }
}
