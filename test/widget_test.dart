import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:locals/app/app.dart';
import 'package:locals/core/localization/locale_controller.dart';
import 'package:locals/core/localization/locale_repository.dart';

import 'package:locals/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets('Locale Controller', (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    final localeRepository = LocaleRepositoryImpl(prefs);
    final localeController = LocaleController(localeRepository);
    await localeController.loadLocale();
    await tester.pumpWidget(MyApp(localeController: localeController));
  });
}
