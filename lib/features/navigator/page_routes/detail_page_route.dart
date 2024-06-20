import 'package:flutter/material.dart';

import '../../../config/routes.dart';
import '../../../widgets/my_error_widget.dart';
import '../../guide/widgets/about_us/about_us_tab.dart';
import '../../study_circle_details/study_circle_details.dart';

class DetailPageRoute extends MaterialPageRoute {
  DetailPageRoute(RouteSettings settings)
      : super(
          builder: switch (settings.name) {
            // here will be more detail routes
            AppRoutes.studyCircleDetails => (_) => const StudyCircleDetails(),
            AppRoutes.aboutUsDetail => (_) => const AboutUsTab(),
            _ => (_) => MyErrorWidget('Invalid route: ${settings.name}')
          },
          settings: settings,
        );
}

