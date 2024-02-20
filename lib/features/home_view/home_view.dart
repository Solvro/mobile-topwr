import 'package:flutter/material.dart';
import '../../config.dart';
import 'widgets/departments_section/department_section.dart';
import 'widgets/news_section.dart';
import 'widgets/study_circles_section.dart';
import 'widgets/buildings_section/buildings_section.dart';
import 'widgets/home_screen_greeting.dart';
import '../../theme/app_theme.dart';
import 'widgets/countdown_widget/exam_session_countdown.dart';
import 'widgets/logo_app_bar.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Widget> sections = [
      const Greeting(),
      const ExamSessionCountdown(),
      const NewsSection(),
      const BuildingsSection(),
      const StudyCirclesSection(),
      const DepartmentSection(),
    ];
    return Scaffold(
      backgroundColor: context.colorTheme.whiteSoap,
      appBar: LogoAppBar(context),
      body: ListView.separated(
        padding: const EdgeInsets.only(bottom: 48),
        itemBuilder: (context, index) => sections[index],
        separatorBuilder: (context, index) => const SizedBox(height: HomeScreenConfig.paddingMedium),
        itemCount: sections.length,
      ),
    );
  }
}
