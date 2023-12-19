import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

import '../../config.dart';
import '../../theme/app_theme.dart';
import '../home_view/home_view.dart';
import 'bottom_nav_bar_controller.dart';
import 'icon_model.dart';

class BottomNavBar extends ConsumerStatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  ConsumerState<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends ConsumerState<BottomNavBar> {
  static final List<Widget> _widgetOptions = <Widget>[
    const HomeView(),
    const _PlaceholderView("Map"),
    const _PlaceholderView("Faculties"),
    const _PlaceholderView("Scientific Circles"),
    const _PlaceholderView("Info"),
  ];

  List<BottomNavigationBarItem> getNavigationBarItems(navigationIndex) {
    List<IconModel> listIconModel = [
      IconModel(icon: BottomNavBarConfig.homeIcon, label: 'Home'),
      IconModel(icon: BottomNavBarConfig.mapIcon, label: 'Map'),
      IconModel(icon: BottomNavBarConfig.schoolIcon, label: 'Faculties'),
      IconModel(
          icon: BottomNavBarConfig.scientificCircleIcon,
          label: 'Scientific Circles'),
      IconModel(icon: BottomNavBarConfig.infoIcon, label: 'Info'),
    ];

    return listIconModel
        .asMap()
        .map((index, iconModel) {
          return MapEntry(
            index,
            BottomNavigationBarItem(
                icon: SvgPicture.asset(iconModel.icon,
                    colorFilter: ColorFilter.mode(
                        index == navigationIndex
                            ? context.colorTheme.orangePomegranade
                            : context.colorTheme.blackMirage.withOpacity(.16),
                        BlendMode.srcIn)),
                label: iconModel.label),
          );
        })
        .values
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    var navigationIndex = ref.watch(navigationControllerProvider);
    return Scaffold(
        body: Center(
          child: _widgetOptions[navigationIndex.index],
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
                  onTap: (value) {
                    ref
                        .read(navigationControllerProvider.notifier)
                        .onIndexChanged(value);
                  },
                  backgroundColor: context.colorTheme.greyLight,
                  showSelectedLabels: false,
                  showUnselectedLabels: false,
                  type: BottomNavigationBarType.fixed,
                  iconSize: 26,
                  items: getNavigationBarItems(navigationIndex.index),
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
