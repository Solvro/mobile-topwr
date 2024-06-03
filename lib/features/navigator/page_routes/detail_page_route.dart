import 'package:flutter/material.dart';

import '../../../widgets/my_error_widget.dart';
import '../../study_circle_details/study_circle_details.dart';

class DetailPageRoute extends MaterialPageRoute {
  DetailPageRoute(RouteSettings settings)
      : super(
          builder: switch (settings.name) {
            AppRoutes.studyCircleDetails => (_) => const StudyCircleDetails(),
            _ => (_) => MyErrorWidget('Invalid route: ${settings.name}')
          },
          settings: settings,
        );
}

abstract class AppRoutes {
  AppRoutes._();

  static const root = '/';
  static const studyCircleDetails = 'study-circle-details';
}
