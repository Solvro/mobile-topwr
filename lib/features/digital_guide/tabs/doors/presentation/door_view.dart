import "package:auto_route/annotations.dart";
import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../../../config/ui_config.dart";
import "../../../../../theme/app_theme.dart";
import "../../../../../utils/context_extensions.dart";
import "../../../../../widgets/detail_views/detail_view_app_bar.dart";
import "../../../../../widgets/horizontal_symmetric_safe_area.dart";
import "../../../../../widgets/my_error_widget.dart";
import "../../../presentation/widgets/accessibility_button.dart";
import "../../../presentation/widgets/accessibility_profile_card.dart";
import "../../../presentation/widgets/bullet_list.dart";
import "../../../presentation/widgets/digital_guide_loading_view.dart";
import "../data/model/door.dart";
import "../data/repository/doors_repository.dart";
import "../domain/doors_accessibility_manager.dart";

@RoutePage()
class DoorView extends ConsumerWidget {
  const DoorView({required this.doorsID});

  final int doorsID;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncDoors = ref.watch(doorsRepositoryProvider(doorsID));

    return asyncDoors.when(
      data: (data) => _DoorsView(door: data),
      error: (error, stackTrace) {
        return HorizontalSymmetricSafeAreaScaffold(
          appBar: DetailViewAppBar(),
          body: MyErrorWidget(error, stackTrace: stackTrace),
        );
      },
      loading: () {
        return const DigitalGuideLoadingView();
      },
    );
  }
}

class _DoorsView extends ConsumerWidget {
  const _DoorsView({required this.door});

  final Door door;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.localize;

    final IList<String> textStrings = [
      if (door.translations.pl.comment.isNotEmpty) door.translations.pl.comment,
      door.translations.pl.fromTo,
      "${l10n.door_visible_from_outside(door.isGoodDoorVisibleFromOutside.toLowerCase())} ${door.translations.pl.isGoodDoorVisibleFromOutsideComment}",
      "${l10n.door_visible_from_inside(door.isGoodDoorVisibleFromInside.toLowerCase())} ${door.translations.pl.isGoodDoorVisibleFromInsideComment}",
      if (door.doorType == DoorType.singleLeafDoor)
        l10n.single_leaf_door
      else if (door.doorType == DoorType.doubleLeafDoor)
        l10n.double_leaf_door
      else if (door.doorType == DoorType.singleLeafDoorSliding)
        l10n.single_leaf_door_sliding
      else if (door.doorType == DoorType.doubleLeafDoorSliding)
        l10n.double_leaf_door_sliding
      else if (door.doorType == DoorType.swingDoor)
        l10n.swing_door,
      "${l10n.main_wing_highlighted(door.isMainWingHighlighted.toLowerCase())} ${door.translations.pl.isMainWingHighlightedComment}",
      "${l10n.increased_force_required(door.isIncreasedForceRequired.toLowerCase())} ${door.translations.pl.isIncreasedForceRequiredComment}",
      "${l10n.door_closer(door.isDoorCloser.toLowerCase())} ${door.translations.pl.isDoorCloserComment}",
    ].map((string) => string.trim()).where((string) => string.isNotEmpty).toIList();

    final widgets = [
      Text(l10n.door, style: context.textTheme.headlineMedium?.copyWith(fontSize: DigitalGuideConfig.headlineFont)),
      const SizedBox(height: DigitalGuideConfig.heightSmall),
      BulletList(items: textStrings),
      const SizedBox(height: DigitalGuideConfig.heightSmall),
      AccessibilityProfileCard(
        accessibilityCommentsManager: DoorsAccessibilityManager(l10n: l10n, door: door),
        backgroundColor: context.colorScheme.surface,
      ),
    ];

    return HorizontalSymmetricSafeAreaScaffold(
      appBar: DetailViewAppBar(actions: [AccessibilityButton()]),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: DigitalGuideConfig.heightBig),
        child: ListView.builder(
          itemCount: widgets.length,
          shrinkWrap: true,
          itemBuilder: (context, index) => widgets[index],
        ),
      ),
    );
  }
}
