import "package:flutter/material.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "../../../config/ui_config.dart";
import "../../../theme/app_theme.dart";
import "../../../utils/context_extensions.dart";
import "../../../widgets/loading_widgets/simple_previews/horizontal_rectangular_section_loading.dart";
import "../data/repository/history_entry_repository.dart";
import "live_indicator.dart";
import "search_streaming_bottom_sheet.dart";

const _maxElementsToShow = 5;

class NowPlayingSection extends ConsumerWidget {
  const NowPlayingSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final historyEntries = ref.watch(historyEntryRepositoryProvider);
    return switch (historyEntries) {
      AsyncData(:final value) => Padding(
        padding: const EdgeInsetsGeometry.symmetric(horizontal: RadioLuzConfig.horizontalBasePadding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 8,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(
            value == null ? 0 : (value.length < _maxElementsToShow ? value.length : _maxElementsToShow),
            (index) => _NowPlayingTile(
              isActive: _maxElementsToShow - 1 == index,
              time: value![index].time.format(context),
              title: value[index].title,
              subtitle: value[index].artist,
            ),
          ),
        ),
      ),
      AsyncLoading() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 8,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(4, (_) => const HorizontalRectangularSectionLoading()),
        ),
      ),
      _ => Column(children: [Text(context.localize.generic_error_message)]),
    };
  }
}

class _NowPlayingTile extends StatelessWidget {
  const _NowPlayingTile({this.isActive = false, required this.time, required this.title, required this.subtitle});
  final bool isActive;
  final String time;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    final colorScheme = context.colorScheme;
    return ListTileTheme(
      child: ListTile(
        horizontalTitleGap: 12,
        visualDensity: VisualDensity.compact,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        tileColor: isActive ? colorScheme.primary : colorScheme.surface,
        dense: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12),
        leading: Text(
          time,
          style: textTheme.titleLarge?.copyWith(color: isActive ? colorScheme.surface : colorScheme.primary),
        ),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: textTheme.titleLarge?.copyWith(
                      color: isActive ? colorScheme.surface : colorScheme.onTertiary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: textTheme.labelSmall?.copyWith(
                      color: isActive ? colorScheme.surface : colorScheme.onTertiary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 4),
            if (isActive)
              LiveIndicator(
                spreadRadius: 8,
                spreadDuration: const Duration(milliseconds: 800),
                waitDuration: const Duration(seconds: 1),
                color: colorScheme.surface,
              ),
          ],
        ),
        trailing: IconButton(
          icon: Icon(Icons.manage_search, color: isActive ? colorScheme.surface : colorScheme.primary),
          onPressed: () => SearchStreamingBottomSheet.show(context, title: title, artist: subtitle),
        ),
      ),
    );
  }
}
