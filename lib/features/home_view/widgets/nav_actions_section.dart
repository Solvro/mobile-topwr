import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../config/ui_config.dart";
import "../../../theme/app_theme.dart";
import "../../../utils/context_extensions.dart";
import "../../activity_days/data/repository/activity_days_repository.dart";
import "../../navigator/utils/navigation_commands.dart";

class NavActionsSection extends ConsumerWidget {
  const NavActionsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isActivityDaysActive = ref.watch(isActivityDaysActiveProvider).value ?? false;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: _NavActionButton(
              key: HomeViewConfig.sksMenuKey,
              context.localize.sks_menu,
              Icon(Icons.restaurant_menu, color: context.colorScheme.surface, size: 32),
              ref.navigateToSksMenu,
            ),
          ),
          Expanded(
            child: _NavActionButton(
              context.localize.parkings_title,
              Icon(Icons.directions_car, color: context.colorScheme.surface, size: 32),
              ref.navigateParkings,
            ),
          ),
          Expanded(
            child: _NavActionButton(
              context.localize.calendar,
              Icon(Icons.calendar_today_outlined, color: context.colorScheme.surface, size: 30),
              ref.navigateCalendar,
            ),
          ),
          if (isActivityDaysActive)
            Expanded(
              child: _NavActionButton(
                context.localize.activity_days_title.replaceFirst(" ", "\n"),
                Icon(Icons.celebration, color: context.colorScheme.surface, size: 32),
                ref.navigateActivityDays,
                color: context.colorScheme.secondary,
              ),
            ),
        ],
      ),
    );
  }
}

class _NavActionButton extends StatelessWidget {
  const _NavActionButton(this.title, this.icon, this.onTap, {this.color}, {super.key});
  final String title;
  final Widget icon;
  final VoidCallback onTap;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final buttonColor = color ?? context.colorScheme.primary;
    return MergeSemantics(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Material(
              color: Colors.transparent,
              child: Ink(
                decoration: BoxDecoration(shape: BoxShape.circle, color: buttonColor),
                child: InkWell(
                  onTap: onTap,
                  borderRadius: BorderRadius.circular(56),
                  splashColor: context.colorScheme.surface.withValues(alpha: 0.3),
                  child: SizedBox.square(dimension: 56, child: Center(child: icon)),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: context.textTheme.bodyMedium,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
