import 'package:flutter/material.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:provider/provider.dart';
import 'package:locals/core/deep_links/app_link_handler.dart';
import 'package:locals/core/localization/app_locales.dart';
import 'package:locals/core/localization/locale_controller.dart';
import 'package:locals/l10n/app_localizations.dart';
import 'router.dart';
import '../shared/theme/app_colors.dart';

class MyApp extends StatefulWidget {
  final LocaleController localeController;

  const MyApp({super.key, required this.localeController});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    AppLinkHandler.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localeController = context.watch<LocaleController>();
    return ChangeNotifierProvider<LocaleController>.value(
      value: widget.localeController,
      child: NeumorphicTheme(
        theme: NeumorphicThemeData(
          baseColor: AppColors.inputBackground,
          accentColor: AppColors.primaryPink,
          lightSource: LightSource.topLeft,
        ),
        child: MaterialApp.router(
          title: 'locals',
          debugShowCheckedModeBanner: false,
          locale: localeController.locale,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          localeResolutionCallback: (deviceLocale, supportedLocales) {
            if (widget.localeController.locale != null) {
              return widget.localeController.locale;
            }
            if (deviceLocale != null) {
              for (final supported in supportedLocales) {
                if (supported.languageCode == deviceLocale.languageCode) {
                  return supported;
                }
              }
            }
            return AppLocales.en;
          },
          theme: ThemeData(
            useMaterial3: true,
            scaffoldBackgroundColor: AppColors.white,
            colorScheme: ColorScheme.fromSeed(
              seedColor: AppColors.primaryPink,
              primary: AppColors.primaryPink,
            ),
          ),
          routerConfig: appRouter,
        ),
      ),
    );
  }
}
