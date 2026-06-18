import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locals/core/localization/l10n_extensions.dart';
import 'package:locals/shared/model/legal_document_section.dart';
import 'package:locals/shared/theme/app_colors.dart';

class LegalDocumentBody extends StatelessWidget {
  final String lastUpdated;
  final List<LegalDocumentSection> sections;

  const LegalDocumentBody({
    super.key,
    required this.lastUpdated,
    required this.sections,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 24.h),
      children: [
        Text(
          context.l10n.legalLastUpdated(lastUpdated),
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: 13.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 20.h),
        for (final section in sections) ...[
          Text(
            section.title,
            style: TextStyle(
              color: AppColors.black,
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 8.h),
          for (final paragraph in section.paragraphs) ...[
            Text(
              paragraph,
              style: TextStyle(
                color: AppColors.textSub2,
                fontSize: 14.sp,
                height: 1.5,
              ),
            ),
            SizedBox(height: 12.h),
          ],
          SizedBox(height: 8.h),
        ],
      ],
    );
  }
}
