import "package:collection/collection.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../config/nav_bar_config.dart";
import "../../theme/app_theme.dart";

class BottomNavBar extends ConsumerWidget {
  const BottomNavBar({super.key, required this.activeIndex, required this.onTap});
  final int activeIndex;
  final void Function(int) onTap;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Theme(
      data: Theme.of(context).copyWith(splashColor: Colors.transparent, highlightColor: Colors.transparent),
      child: DecoratedBox(
        decoration: BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(color: Colors.black.withValues(alpha: .08), blurRadius: 20, offset: const Offset(0, -1)),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: activeIndex,
          onTap: onTap,
          backgroundColor: context.colorTheme.greyLight,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          items: _NavigationBarItemsList(activeIndex, context),
        ),
      ),
    );
  }
}

class _NavigationBarItemsList extends DelegatingList<BottomNavigationBarItem> {
  _NavigationBarItemsList(int activeIndex, BuildContext context)
    : super(
        NavBarEnum.values
            .mapIndexed(
              (i, e) => BottomNavigationBarItem(
                icon: Icon(
                  e.icon,
                  color:
                      i == activeIndex
                          ? context.colorTheme.orangePomegranade
                          : context.colorTheme.blackMirage.withValues(alpha: .16),
                  size: e.size,
                ),
                label: e.getLabel(context),
              ),
            )
            .toList(),
      );
}
