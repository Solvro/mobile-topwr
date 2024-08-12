import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";

import "../../config/ui_config.dart";
import "../../theme/app_theme.dart";
import "../academic_calendar/widgets/countdown_widget/exam_session_countdown.dart";
import "../academic_calendar/widgets/home_screen_greeting.dart";
import "widgets/buildings_section/buildings_section.dart";
import "widgets/departments_section/departments_section.dart";
import "widgets/logo_app_bar.dart";
import "widgets/news_section.dart";
import "widgets/parkings_section.dart";
import "widgets/science_clubs_section.dart";

@RoutePage()
class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Widget> sections = [
      const Greeting(),
      const ExamSessionCountdown(),
      const ParkingsSection(),
      const ScienceClubsSection(),
      const BuildingsSection(),
      const NewsSection(),
      const DepartmentsSection(),
    ];
    return Scaffold(
      backgroundColor: context.colorTheme.whiteSoap,
      appBar: LogoAppBar(context),
      body: ListView.separated(
        padding: const EdgeInsets.only(bottom: 48),
        itemBuilder: (context, index) => sections[index],
        separatorBuilder: (context, index) =>
            const SizedBox(height: HomeViewConfig.paddingMedium),
        itemCount: sections.length,
      ),
    );
  }
}
