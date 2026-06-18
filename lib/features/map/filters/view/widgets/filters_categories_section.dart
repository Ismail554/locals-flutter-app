import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locals/core/localization/filters_l10n.dart';
import 'package:locals/core/localization/l10n_extensions.dart';
import '../../model/filters_model.dart';
import 'filters_category_chip.dart';
import 'filters_section_label.dart';

class FiltersCategoriesSection extends StatelessWidget {
  final Set<String> selectedIds;
  final ValueChanged<String> onToggle;

  const FiltersCategoriesSection({
    super.key,
    required this.selectedIds,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FiltersSectionLabel(label: l10n.filtersCategories),
        SizedBox(height: 12.h),
        LayoutBuilder(
          builder: (context, constraints) {
            final chipWidth = (constraints.maxWidth - 10.w) / 2;
            return Wrap(
              spacing: 10.w,
              runSpacing: 10.h,
              children: [
                for (final category in MapFiltersState.categories)
                  SizedBox(
                    width: chipWidth,
                    child: FiltersCategoryChip(
                      emoji: category.emoji,
                      label: FiltersL10n.categoryLabel(l10n, category.id),
                      isSelected: selectedIds.contains(category.id),
                      onTap: () => onToggle(category.id),
                    ),
                  ),
              ],
            );
          },
        ),
      ],
    );
  }
}
