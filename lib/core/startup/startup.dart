import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:locals/core/localization/locale_controller.dart';
import 'package:locals/core/localization/locale_repository.dart';
import '../../app/app.dart';

void startFlutterApp() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final localeController = LocaleController(LocaleRepositoryImpl(prefs));
  await localeController.loadLocale();

  runApp(
    ScreenUtilInit(
      designSize: const Size(440, 956),
      minTextAdapt: true,
      builder: (context, child) => ChangeNotifierProvider<LocaleController>.value(
        value: localeController,
        child: const MyApp(),
      ),
    ),
  );
}
