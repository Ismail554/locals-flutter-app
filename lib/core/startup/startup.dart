import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locals/core/deep_links/app_link_handler.dart';
import 'package:locals/core/network/token_manager.dart';
import 'package:locals/core/notifications/fcm_service.dart';
import 'package:locals/core/notifications/notification_service.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:locals/core/localization/locale_controller.dart';
import 'package:locals/core/localization/locale_repository.dart';
import '../../app/app.dart';

void startFlutterApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await NotificationService.instance.initialize();
  await FCMService.registerDeviceToken();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await dotenv.load(fileName: ".env");
  await TokenManager().init();
  await AppLinkHandler.init();

  final prefs = await SharedPreferences.getInstance();
  final localeController = LocaleController(LocaleRepositoryImpl(prefs));
  await localeController.loadLocale();

  runApp(
    ScreenUtilInit(
      designSize: const Size(440, 956),
      minTextAdapt: true,
      builder: (context, child) =>
          ChangeNotifierProvider<LocaleController>.value(
            value: localeController,
            child: MyApp(localeController: localeController),
          ),
    ),
  );
}
