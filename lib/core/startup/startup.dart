import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../app/app.dart';

void startFlutterApp() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ScreenUtilInit(
      designSize: const Size(440,956),
      minTextAdapt: true,
      builder: (context, child) => const MyApp(),
    ),
  );
}
