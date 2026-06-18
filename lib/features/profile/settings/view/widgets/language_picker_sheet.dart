import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locals/core/localization/app_locales.dart';
import 'package:locals/core/localization/l10n_extensions.dart';
import 'package:locals/shared/theme/app_colors.dart';

class LanguagePickerSheet extends StatelessWidget {
  final Locale selectedLocale;

  const LanguagePickerSheet({super.key, required this.selectedLocale});

  static Future<Locale?> show(BuildContext context, Locale selectedLocale) {
    return showModalBottomSheet<Locale>(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (context) => LanguagePickerSheet(selectedLocale: selectedLocale),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 24.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.languagePickerTitle,
              style: TextStyle(
                color: AppColors.black,
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 12.h),
            for (final locale in AppLocales.supported)
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  AppLocales.localizedDisplayName(l10n, locale),
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                trailing: selectedLocale.languageCode == locale.languageCode
                    ? Icon(Icons.check, color: AppColors.actionPink, size: 22.sp)
                    : null,
                onTap: () => Navigator.pop(context, locale),
              ),
          ],
        ),
      ),
    );
  }
}
