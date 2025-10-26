import "package:flutter/material.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "../../../theme/app_theme.dart";
import "../../../utils/context_extensions.dart";
import "../data/repository/history_entry_repository.dart";

const _maxElementsToShow = 5;

class NowPlaygingSection extends ConsumerWidget {
  const NowPlaygingSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final historyEntries = ref.watch(historyEntryRepositoryProvider);
    return switch (historyEntries) {
      AsyncData(:final value) => Column(
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
      // TODO(tt): add shimmer effect
      AsyncLoading() => Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: CircularProgressIndicator(color: context.colorTheme.orangePomegranade),
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
    final colorTheme = context.colorTheme;
    return ListTileTheme(
      child: ListTile(
        horizontalTitleGap: 12,
        visualDensity: VisualDensity.compact,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        tileColor: isActive ? colorTheme.orangePomegranadeLighter : colorTheme.whiteSoap,
        dense: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12),
        leading: Text(
          time,
          style: textTheme.title.copyWith(color: isActive ? colorTheme.whiteSoap : colorTheme.orangePomegranadeLighter),
        ),
        title: Text(
          title,
          style: textTheme.title.copyWith(color: isActive ? colorTheme.whiteSoap : colorTheme.blackMirage),
        ),
        subtitle: Text(
          subtitle,
          style: textTheme.tiny.copyWith(color: isActive ? colorTheme.whiteSoap : colorTheme.blackMirage),
        ),
        trailing: isActive
            ? Text(
                context.localize.now_playing.toUpperCase(),
                style: textTheme.tiny.copyWith(
                  color: isActive ? colorTheme.whiteSoap : colorTheme.blackMirage,
                  fontWeight: FontWeight.w400,
                ),
              )
            : null,
      ),
    );
  }
}
