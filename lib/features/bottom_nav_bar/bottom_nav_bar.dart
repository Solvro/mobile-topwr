import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../theme/app_theme.dart';
import '../home_view/home_view.dart';
import 'bottom_nav_bar_controller.dart';
import 'nav_bar_enum.dart';


class BottomNavBar extends ConsumerWidget {
  const BottomNavBar({super.key});

  static const _widgetOptions = UnmodifiableNavBarEnumMap(
    home: HomeView(),
    mapp: _PlaceholderView("Map"),
    faculties: _PlaceholderView("Faculties"),
    sciCircles: _PlaceholderView("Scientific Circles"),
    info: _PlaceholderView("Info"),
  );

  List<BottomNavigationBarItem> getNavigationBarItems(
    BuildContext context,
    NavBarEnum navigationIndex,
  ) {
    return NavBarEnum.values
        .map((e) => BottomNavigationBarItem(
              icon: Icon(
                e.icon,
                color: e == navigationIndex
                    ? context.colorTheme.orangePomegranade
                    : context.colorTheme.blackMirage.withOpacity(.16),
                size: e.size,
              ),
              label: e.label,
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var navigationIndex = ref.watch(bottomNavBarControllerProvider);
    return Scaffold(
        body: Center(
          child: _widgetOptions[navigationIndex],
        ),
        bottomNavigationBar: Theme(
            data: Theme.of(context).copyWith(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
            ),
            child: Container(
                decoration: BoxDecoration(
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.black.withOpacity(.08),
                      blurRadius: 20,
                      offset: const Offset(0, -1),
                    ),
                  ],
                ),
                child: BottomNavigationBar(
                  currentIndex: navigationIndex.index,
                  onTap: ref
                      .watch(bottomNavBarControllerProvider.notifier)
                      .onIndexChanged,
                  backgroundColor: context.colorTheme.greyLight,
                  showSelectedLabels: false,
                  showUnselectedLabels: false,
                  type: BottomNavigationBarType.fixed,
                  items: getNavigationBarItems(context, navigationIndex),
                )
            )
        )
    );
  }
}

class _PlaceholderView extends StatelessWidget {
  /// Placeholder view created to test navigation between pages
  const _PlaceholderView(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Text(text),
      )
    );
  }
}
