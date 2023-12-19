import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'features/bottom_nav_bar/botom_nav_bar.dart';

import 'config.dart';
import 'features/splash_screen/splash_screen.dart';
import 'features/splash_screen/splash_screen_controller.dart';
import 'theme/app_theme.dart';

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
      theme: ThemeData(extensions: const [AppTheme()]),
      home: const BottomNavBar(),
    );
  }
}
