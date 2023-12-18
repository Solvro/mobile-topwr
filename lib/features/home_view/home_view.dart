import 'package:flutter/material.dart';
import 'widgets/home_screen_greeting.dart';
import 'widgets/logo_app_bar.dart';
import '../../theme/app_theme.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorTheme.whiteSoap,
      appBar: LogoAppBar(context),
      body: ListView(children: const [Greeting()]),
    );
  }
}

class _Placeholders extends StatelessWidget {
  /// Scroll behaviour testing purposes: list of 15 placeholders
  const _Placeholders();

  @override
  Widget build(BuildContext context) {
    return ListView(
        children: List.generate(
            15,
            (index) => const SizedBox(
                  height: 200,
                  child: Placeholder(),
                )));
  }
}
