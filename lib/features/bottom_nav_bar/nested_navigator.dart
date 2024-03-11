import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../widgets/my_error_widget.dart';
import '../details_screen/study_circle_details.dart';
import 'bottom_nav_bar_controller.dart';
import 'nav_bar_config.dart';
import 'root_view_pages.dart';

class NestedNavigator {
  NestedNavigator(this.ref);
  final Ref ref;
  final navigatorKey = GlobalKey<NavigatorState>();

  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: switch (settings.name) {
        _Routes.root => (_) => const RootViewPages(),
        _Routes.studyCircleDetails => (_) => const StudyCircleDetails(),
        _ => (_) => MyErrorWidget('Invalid route: ${settings.name}')
      },
      settings: settings,
    );
  }

  void navigateToStudyCircleDetails(String argument) {
    ref
        .read(bottomNavBarControllerProvider.notifier)
        .goTo(NavBarEnum.sciCircles); // change tab

    navigatorKey.currentState?.pushNamed(
      _Routes.studyCircleDetails,
      arguments: argument,
    ); // and push detail view
  }

  void popUntilRoot() {
    navigatorKey.currentState?.popUntil((route) => route.isFirst);
  }
}

class _Routes {
  _Routes._(); //no constructor available

  static const root = '/';
  static const studyCircleDetails = 'study-circle-details';
}

final navigatorProvider = Provider<NestedNavigator>((ref) {
  return NestedNavigator(ref);
});
