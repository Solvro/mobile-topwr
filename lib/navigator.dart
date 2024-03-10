import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'features/bottom_nav_bar/bottom_nav_bar.dart';
import 'features/details_screen/study_circle_details.dart';
import 'widgets/my_error_widget.dart';

class AppNavigator {
  final navigatorKey = GlobalKey<NavigatorState>();

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return CupertinoPageRoute(
      builder: switch (settings.name) {
        _Routes.home => (_) => const BottomNavBar(),
        _Routes.studyCircleDetails => (_) => const StudyCircleDetails(),
        _ => (_) => MyErrorWidget('Invalid route: ${settings.name}')
      },
      settings: settings,
    );
  }

  void navigateToStudyCircleDetails(String argument) {
    navigatorKey.currentState
        ?.pushNamed(_Routes.studyCircleDetails, arguments: argument);
  }
}

class _Routes {
  _Routes._(); //no constructor available

  static const home = '/';
  static const studyCircleDetails = 'study-circle-details';
}

final navigatorProvider = Provider<AppNavigator>((ref) {
  return AppNavigator();
});