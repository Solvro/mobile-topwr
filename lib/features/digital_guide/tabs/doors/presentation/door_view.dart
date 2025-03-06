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
        return HorizontalSymmetricSafeAreaScaffold(appBar: DetailViewAppBar(), body: MyErrorWidget(error));
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
    final IList<String> textStrings =
        [
          if (door.translations.pl.comment.isNotEmpty) door.translations.pl.comment,
          door.translations.pl.fromTo,
          "${context.localize.door_visible_from_outside(door.isGoodDoorVisibleFromOutside)} ${door.translations.pl.isGoodDoorVisibleFromOutsideComment}",
          "${context.localize.door_visible_from_inside(door.isGoodDoorVisibleFromInside)} ${door.translations.pl.isGoodDoorVisibleFromInsideComment}",
          if (door.doorType == DoorType.singleLeafDoor)
            context.localize.single_leaf_door
          else if (door.doorType == DoorType.doubleLeafDoor)
            context.localize.double_leaf_door
          else if (door.doorType == DoorType.singleLeafDoor)
            context.localize.single_leaf_door_sliding
          else if (door.doorType == DoorType.doubleLeafDoorSliding)
            context.localize.double_leaf_door_sliding
          else if (door.doorType == DoorType.swingDoor)
            context.localize.swing_door,
          "${context.localize.main_wing_highlighted(door.isMainWingHighlighted)} ${door.translations.pl.isMainWingHighlightedComment}",
          "${context.localize.increased_force_required(door.isIncreasedForceRequired)} ${door.translations.pl.isIncreasedForceRequiredComment}",
          "${context.localize.door_closer(door.isDoorCloser)} ${door.translations.pl.isDoorCloserComment}",
        ].map((string) => string.trim()).where((string) => string.isNotEmpty).toIList();

    return Scaffold(
      appBar: DetailViewAppBar(actions: [AccessibilityButton()]),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: DigitalGuideConfig.heightBig),
        child: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate([
                Text(
                  context.localize.door,
                  style: context.textTheme.headline.copyWith(fontSize: DigitalGuideConfig.headlineFont),
                ),
                const SizedBox(height: DigitalGuideConfig.heightMedium),
                BulletList(items: textStrings),
                const SizedBox(height: DigitalGuideConfig.heightMedium),
                AccessibilityProfileCard(
                  accessibilityCommentsManager: DoorsAccessibilityManager(l10n: l10n, door: door),
                  backgroundColor: context.colorTheme.whiteSoap,
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
