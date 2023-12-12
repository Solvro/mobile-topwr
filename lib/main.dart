import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'features/splash_screen/splash_screen.dart';
import 'features/splash_screen/splash_screen_controller.dart';
import 'theme/app_theme.dart';

void main() async {
  SplashScreenController.preserveNativeSplashScreen();
  runApp(
    const ProviderScope(
      child: SplashScreen(
        additionalWaitDuration: Duration(seconds: 1),
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
      title: 'ToPwr',
      theme: ThemeData(extensions: const [AppTheme()]),
      home: const Placeholder(),
    );
  }
}
