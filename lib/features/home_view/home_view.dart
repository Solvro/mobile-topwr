import 'package:flutter/material.dart';
import 'package:topwr/features/home_view/widgets/home_screen_greeting.dart';

import '../../theme/app_theme.dart';
import 'widgets/logo_app_bar.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorTheme.whiteSoap,
      appBar: LogoAppBar(context),
      body: Padding(
        padding: EdgeInsets.all(24),
        child: ListView(children: [
          Greeting()
        ]),
      ),
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
