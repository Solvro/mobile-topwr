import 'package:flutter/material.dart';
import 'package:topwr/features/home_view/widgets/exam_session_countdown.dart';

import '../../theme/app_theme.dart';
import 'widgets/logo_app_bar.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorTheme.whiteSoap,
      appBar: LogoAppBar(context),
      body: const _Placeholders(),
    );
  }
}

class _Placeholders extends StatelessWidget {
  /// Scroll behaviour testing purposes: list of 15 placeholders
  const _Placeholders();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ExamSessionCountdown(examDate: DateTime(2024, 01,14),),
      ],
    );
  }
}
