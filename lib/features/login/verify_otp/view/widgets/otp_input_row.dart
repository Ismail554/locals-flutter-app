import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locals/shared/theme/app_colors.dart';

class OtpInputRow extends StatelessWidget {
  final List<TextEditingController> controllers;
  final List<FocusNode> focusNodes;
  final void Function(int index, String value) onDigitChanged;

  const OtpInputRow({
    super.key,
    required this.controllers,
    required this.focusNodes,
    required this.onDigitChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(4, (index) {
        return Flexible(
          flex: 1,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 6.w),
            child: Neumorphic(
              style: NeumorphicStyle(
                depth: -2,
                color: AppColors.inputBackground,
                boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(16.r)),
              ),
              child: TextField(
                controller: controllers[index],
                focusNode: focusNodes[index],
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                maxLength: 1,
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.black,
                ),
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: const InputDecoration(
                  counterText: '',
                  border: InputBorder.none,
                ),
                onChanged: (value) => onDigitChanged(index, value),
              ),
            ),
          ),
        );
      }),
    );
  }
}
