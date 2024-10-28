import "package:auto_route/auto_route.dart";
import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";

import "../../config/ui_config.dart";
import "../../theme/app_theme.dart";
import "../academic_calendar/widgets/academic_calendar_consumer.dart";
import "keep_alive_home_view_providers.dart";
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
    final sections = [
      const AcademicCalendarConsumer(),
      const ParkingsSection(),
      const ScienceClubsSection(),
      const BuildingsSection(),
      const NewsSection(),
      const DepartmentsSection(),
    ].lock;
    return Scaffold(
      backgroundColor: context.colorTheme.whiteSoap,
      appBar: LogoAppBar(context),
      body: KeepAliveHomeViewProviders(
        child: ListView.separated(
          padding:
              const EdgeInsets.only(bottom: HomeViewConfig.bottomPadding),
          itemBuilder: (context, index) => sections[index],
          separatorBuilder: (context, index) => SizedBox(
            height: index == 1 ? 0 : HomeViewConfig.paddingMedium,
          ),
          itemCount: sections.length,
        ),
      ),
    );
  }
}
