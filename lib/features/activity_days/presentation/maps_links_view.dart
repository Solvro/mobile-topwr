import "package:auto_route/auto_route.dart";
import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "../../../theme/app_theme.dart";
import "../../../utils/context_extensions.dart";
import "../../../widgets/general_offline_message.dart";
import "../data/repository/activity_days_repository.dart";
import "widgets/link_tile.dart";
import "widgets/map_tile.dart";

@RoutePage()
class MapsLinksView extends HookConsumerWidget {
  const MapsLinksView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = useState(_Tab.maps);
    final l10n = context.localize;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: CupertinoSlidingSegmentedControl<_Tab>(
            groupValue: selected.value,
            backgroundColor: context.colorScheme.surfaceTint,
            thumbColor: context.colorScheme.primaryContainer,
            onValueChanged: (value) {
              if (value != null) selected.value = value;
            },
            children: {
              _Tab.maps: _SegmentTab(
                label: l10n.activity_days_segment_maps,
                isSelected: selected.value == _Tab.maps,
              ),
              _Tab.links: _SegmentTab(
                label: l10n.activity_days_segment_links,
                isSelected: selected.value == _Tab.links,
              ),
            },
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: selected.value == _Tab.maps ? const _MapsTab() : const _LinksTab(),
          ),
        ),
      ],
    );
  }
}

enum _Tab { maps, links }

class _SegmentTab extends StatelessWidget {
  const _SegmentTab({required this.label, required this.isSelected});

  final String label;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Center(
        child: Text(
          label,
          style: isSelected
              ? context.textTheme.bodyMedium?.copyWith(color: context.colorScheme.surface)
              : context.textTheme.bodyMedium,
        ),
      ),
    );
  }
}

class _MapsTab extends ConsumerWidget {
  const _MapsTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(activityDaysRepositoryProvider);
    return async.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (_, _) => _OfflineView(onRefresh: () => ref.invalidate(activityDaysRepositoryProvider)),
      data: (event) {
        final maps = event?.maps ?? const IListConst([]);
        if (maps.isEmpty) {
          return _OfflineView(onRefresh: () => ref.invalidate(activityDaysRepositoryProvider));
        }
        return ListView.builder(
          itemCount: maps.length,
          itemBuilder: (_, i) => MapTile(map: maps[i]),
        );
      },
    );
  }
}

class _LinksTab extends ConsumerWidget {
  const _LinksTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(activityDaysRepositoryProvider);
    return async.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (_, _) => _OfflineView(onRefresh: () => ref.invalidate(activityDaysRepositoryProvider)),
      data: (event) {
        final links = event?.links ?? const IListConst([]);
        if (links.isEmpty) {
          return _OfflineView(onRefresh: () => ref.invalidate(activityDaysRepositoryProvider));
        }
        return ListView.separated(
          itemCount: links.length,
          separatorBuilder: (_, _) => const SizedBox(height: 12),
          itemBuilder: (_, i) => LinkTile(link: links[i]),
        );
      },
    );
  }
}

class _OfflineView extends StatelessWidget {
  const _OfflineView({required this.onRefresh});

  final VoidCallback onRefresh;

  @override
  Widget build(BuildContext context) {
    return OfflineMessage(context.localize.offline_error_message, onRefresh: onRefresh);
  }
}
