import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../widgets/my_error_widget.dart';
import 'widgets/buildings_section/buildings_section.dart';
import 'widgets/countdown_widget/exam_session_countdown.dart';
import 'widgets/departments_section/department_section.dart';
import 'widgets/home_screen_greeting.dart';
import 'widgets/logo_app_bar.dart';
import 'widgets/study_circles_section.dart';
import '../../config.dart';
import '../../theme/app_theme.dart';
import '../details_screen/study_circle_details.dart';
import 'widgets/news_section.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return _HomeViewNavigator();
  }
}
class _HomeViewNavigator extends StatelessWidget {
  _HomeViewNavigator({super.key});

  final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {

    return PopScope(
      canPop: _navigatorKey.currentState?.canPop() ?? false,
      onPopInvoked: (bool isPop) {
        if (_navigatorKey.currentState?.canPop() ?? false) {
          _navigatorKey.currentState?.pop();
        }
      },
      child: Navigator(
        key: _navigatorKey,
        onGenerateRoute: (settings) {
          WidgetBuilder builder;
          switch (settings.name) {
            case _Routes.home:
              builder = (BuildContext _) =>
                  _HomeViewScreen(onNavigate: navigateToStudyCircleDetails);
              break;
            case _Routes.studyCircleDetails:
              builder = (BuildContext _) => const StudyCircleDetails();
              break;
            default:
              builder = (BuildContext _) =>
                  MyErrorWidget('Invalid route: ${settings.name}');
          }
          return CupertinoPageRoute(builder: builder, settings: settings);
        },
      ),
    );
  }

  void navigateToStudyCircleDetails(String argument) {
    _navigatorKey.currentState
        ?.pushNamed(_Routes.studyCircleDetails, arguments: argument);
  }
}

class _HomeViewScreen extends StatelessWidget {
  const _HomeViewScreen({super.key, required this.onNavigate});

  final Function(String) onNavigate;

  @override
  Widget build(BuildContext context) {
    final List<Widget> sections = [
      const Greeting(),
      const ExamSessionCountdown(),
      const NewsSection(),
      const BuildingsSection(),
      StudyCirclesSection(onNavigate: onNavigate),
      const DepartmentSection(),
    ];

    return Scaffold(
      backgroundColor: context.colorTheme.whiteSoap,
      appBar: LogoAppBar(context),
      body: ListView.separated(
        padding: const EdgeInsets.only(bottom: 48),
        itemBuilder: (context, index) => sections[index],
        separatorBuilder: (context, index) =>
            const SizedBox(height: HomeScreenConfig.paddingMedium),
        itemCount: sections.length,
      ),
    );
  }
}

class _Routes {
  static const home = '/';
  static const studyCircleDetails = 'study-circle-details';
}
