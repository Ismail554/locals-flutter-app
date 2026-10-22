import 'package:locals/l10n/app_localizations.dart';

class FiltersL10n {
  FiltersL10n._();

  static String categoryLabel(AppLocalizations l10n, String id) {
    final normalized = id.trim().toLowerCase().replaceAll('_', ' ');
    return switch (normalized) {
      'restaurant' => l10n.filterCategoryRestaurant,
      'bar' => l10n.filterCategoryBar,
      'cafe' => l10n.filterCategoryCafe,
      'bakery' => l10n.filterCategoryBakery,
      'shop' => l10n.filterCategoryShop,
      'market' => l10n.filterCategoryMarket,
      'monument' => l10n.filterCategoryMonument,
      'cultural' => l10n.filterCategoryCultural,
      'cultural space' => l10n.filterCategoryCultural,
      'viewpoint' => l10n.filterCategoryViewpoint,
      'square' => l10n.filterCategorySquare,
      'park' || 'parks and gardens' => l10n.filterCategoryParksGardens,
      'other' => l10n.filterCategoryOther,
      _ => id,
    };
  }
}
