import 'package:flutter/material.dart';
import 'widgets/home_screen_greeting.dart';
import '../../theme/app_theme.dart';
import 'widgets/exam_session_countdown.dart';
import 'widgets/logo_app_bar.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorTheme.whiteSoap,
      appBar: LogoAppBar(context),
      body: ListView(children: const [Greeting(),   ExamSessionCountdown(),),
    );
  }
}
