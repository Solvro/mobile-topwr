import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'config/ui_config.dart';
import 'features/navigator/root_navigator_widget.dart';
import 'features/splash_screen/splash_screen.dart';
import 'features/splash_screen/splash_screen_controller.dart';
import 'theme/app_theme.dart';
import 'theme/colors.dart';

void main() async {
  SplashScreenController.preserveNativeSplashScreen();
  runApp(
    const ProviderScope(
      child: SplashScreen(
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: MyAppConfig.title,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: ThemeData(
          extensions: const [AppTheme()],
          colorScheme: const ColorScheme.light().copyWith(
            surface: ColorsConsts.whiteSoap,
          )),
      debugShowCheckedModeBanner: false,
      home: const RootNavigatorWidget(),
    );
  }
}
