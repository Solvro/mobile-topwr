import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../../config/ui_config.dart";
import "../../../../theme/app_theme.dart";
import "../../../../utils/context_extensions.dart";
import "../../../../widgets/my_error_widget.dart";
import "../../../../widgets/wide_tile_card.dart";
import "../../business/activity_days_stands_use_case.dart";

class ActivityDaysStands extends ConsumerWidget {
  const ActivityDaysStands({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final floors = ref.watch(dasStandsByFloorUseCaseProvider);

    return switch (floors) {
      AsyncError(:final error, :final stackTrace) => MyErrorWidget(error, stackTrace: stackTrace),
      AsyncData(:final value) =>
        value.isEmpty ? Center(child: Text(context.localize.generic_error_message)) : _StandsSection(floors: value),
      _ => const Center(child: CircularProgressIndicator()),
    };
  }
}

class _StandsSection extends HookWidget {
  const _StandsSection({required this.floors});

  final IList<StandsFloor> floors;

  @override
  Widget build(BuildContext context) {
    final selected = useState(floors.first.floorId ?? _noFloorKey);

    if (floors.length == 1) {
      return _FloorStands(floor: floors.first);
    }

    final current = floors.firstWhere(
      (floor) => (floor.floorId ?? _noFloorKey) == selected.value,
      orElse: () => floors.first,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: HomeViewConfig.paddingLarge,
            vertical: HomeViewConfig.paddingMedium,
          ),
          child: CupertinoSlidingSegmentedControl<int>(
            backgroundColor: context.colorScheme.surfaceTint,
            thumbColor: context.colorScheme.primaryContainer,
            groupValue: selected.value,
            onValueChanged: (value) {
              if (value != null) selected.value = value;
            },
            children: {
              for (final floor in floors)
                (floor.floorId ?? _noFloorKey): _SegmentLabel(
                  label: _floorLabel(context, floor.floorId),
                  isSelected: selected.value == (floor.floorId ?? _noFloorKey),
                ),
            },
          ),
        ),
        Expanded(child: _FloorStands(floor: current)),
      ],
    );
  }
}

class _SegmentLabel extends StatelessWidget {
  const _SegmentLabel({required this.label, required this.isSelected});

  final String label;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
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

class _FloorStands extends StatelessWidget {
  const _FloorStands({required this.floor});

  final StandsFloor floor;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(
        horizontal: HomeViewConfig.paddingLarge,
        vertical: HomeViewConfig.paddingSmall,
      ),
      itemCount: floor.stands.length,
      itemBuilder: (context, index) {
        final stand = floor.stands[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: HomeViewConfig.paddingSmall),
          child: PhotoTrailingWideTileCard(
            context,
            directusPhotoUrl: stand.logo,
            title: stand.number,
            subtitle: stand.name,
            onTap: () {},
          ),
        );
      },
    );
  }
}

const _noFloorKey = -1;

String _floorLabel(BuildContext context, int? floorId) =>
    floorId == null ? context.localize.nav_others : "${context.localize.level} $floorId";
