import 'package:flutter/material.dart';

import 'theme/app_theme.dart';

void main() {
  runApp(const MyApp());
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
