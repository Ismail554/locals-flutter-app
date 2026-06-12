import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'router.dart';
import '../shared/theme/app_colors.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return NeumorphicTheme(
      theme: NeumorphicThemeData(
        baseColor: AppColors.inputBackground,
        accentColor: AppColors.primaryPink,
        lightSource: LightSource.topLeft,
      ),
      child: MaterialApp.router(
        title: 'locals',
        debugShowCheckedModeBanner: false,
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
    );
  }
}
