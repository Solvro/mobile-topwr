import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../theme/app_theme.dart";
import "../../../utils/context_extensions.dart";
import "../../navigator/utils/navigation_commands.dart";

class NavActionsSection extends ConsumerWidget {
  const NavActionsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => Center(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Wrap(
            alignment: WrapAlignment.spaceEvenly,
            crossAxisAlignment: WrapCrossAlignment.center,
            runAlignment: WrapAlignment.spaceEvenly,
            runSpacing: 12,
            spacing: 12,

            children: [
              _NavActionButton(
                context.localize.sks_menu,
                Icon(Icons.restaurant_menu, color: context.colorTheme.whiteSoap, size: 32),
                ref.navigateToSksMenu,
              ),
              _NavActionButton(
                context.localize.parkings_title,
                Icon(Icons.directions_car, color: context.colorTheme.whiteSoap, size: 32),
                ref.navigateParkings,
              ),
              _NavActionButton(
                context.localize.calendar,
                Icon(Icons.calendar_today_outlined, color: context.colorTheme.whiteSoap, size: 30),
                ref.navigateCalendar,
              ),
              _NavActionButton(
                context.localize.radio_luz,
                Icon(Icons.calendar_today_outlined, color: context.colorTheme.whiteSoap, size: 30),
                ref.navigateToRadioLuz,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

class _NavActionButton extends StatelessWidget {
  const _NavActionButton(this.title, this.icon, this.onTap);
  final String title;
  final Widget icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return MergeSemantics(
      child: Column(
        children: [
          Material(
            color: Colors.transparent,
            child: Ink(
              decoration: BoxDecoration(shape: BoxShape.circle, color: context.colorTheme.orangePomegranade),
              child: InkWell(
                onTap: onTap,
                borderRadius: BorderRadius.circular(56),
                splashColor: context.colorTheme.whiteSoap.withValues(alpha: 0.3),
                child: SizedBox.square(dimension: 56, child: Center(child: icon)),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(title, style: context.textTheme.boldBody),
        ],
      ),
    );
  }
}
