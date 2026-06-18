import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:locals/core/localization/app_locales.dart';
import 'package:locals/core/localization/l10n_extensions.dart';
import 'package:locals/core/localization/locale_controller.dart';
import 'package:locals/core/localization/settings_l10n.dart';
import 'package:locals/shared/components/premium_confirm_dialog.dart';
import 'package:provider/provider.dart';
import '../model/settings_model.dart';
import '../repository/settings_repository.dart';
import '../view/widgets/language_picker_sheet.dart';

class SettingsController extends ChangeNotifier {
  final SettingsRepository repo;

  SettingsController(this.repo);

  List<SettingsSection> sectionsFor(BuildContext context) {
    final l10n = context.l10n;
    final localeController = context.read<LocaleController>();
    final locale =
        localeController.locale ?? Localizations.localeOf(context);
    final languageName = AppLocales.localizedDisplayName(l10n, locale);
    return SettingsL10n.buildSections(l10n, languageName);
  }

  void handleItemTap(BuildContext context, String itemId) {
    switch (itemId) {
      case 'language':
        pickLanguage(context);
      case 'notification':
        context.push('/set_notification');
      case 'privacy':
        context.push('/privacy');
      case 'edit_profile':
        context.push('/edit_profile');
      case 'help':
        context.push('/help_support');
      case 'policy':
        context.push('/privacy_data');
      case 'rate':
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(context.l10n.snackbarThanksFeedback)),
        );
      case 'logout':
        confirmLogout(context);
      default:
        break;
    }
  }

  Future<void> pickLanguage(BuildContext context) async {
    final localeController = context.read<LocaleController>();
    final current =
        localeController.locale ?? Localizations.localeOf(context);

    final selected = await LanguagePickerSheet.show(context, current);
    if (selected == null || !context.mounted) return;

    await localeController.setLocale(selected);
    notifyListeners();
  }

  Future<void> confirmLogout(BuildContext context) async {
    final shouldLogout = await PremiumConfirmDialog.showLogout(context);
    if (!shouldLogout || !context.mounted) return;
    context.go('/login');
  }
}
