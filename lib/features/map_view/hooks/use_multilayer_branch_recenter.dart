import "dart:async";

import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "../../../config/map_view_config.dart";
import "../../branches/data/model/branch.dart";
import "../../multilayer_map/data/model/multilayer_item.dart";
import "../controllers/bottom_sheet_controller.dart";
import "../controllers/controllers_set.dart";

void useMultilayerBranchRecenter({
  required WidgetRef ref,
  required Branch? selectedBranch,
  required AsyncValue<IList<MultilayerItem>> sourceState,
  required ActiveMarkerProv<MultilayerItem> activeMarkerProvider,
  required MapControllerProv<MultilayerItem> mapControllerProvider,
}) {
  final lastHandledBranch = useRef<Branch?>(selectedBranch);
  final pendingBranchRecenter = useState<Branch?>(null);

  useEffect(() {
    if (selectedBranch == null || lastHandledBranch.value == selectedBranch) return null;

    lastHandledBranch.value = selectedBranch;
    pendingBranchRecenter.value = selectedBranch;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(activeMarkerProvider.notifier).unselect();
      ref.read(bottomSheetControllerProvider).resetSafe();
    });
    return null;
  }, [selectedBranch]);

  useEffect(() {
    final branchToRecenter = pendingBranchRecenter.value;
    if (branchToRecenter == null) return null;

    switch (sourceState) {
      case AsyncValue(:final value) when value != null:
        final buildings = value
            .whereType<BuildingItem>()
            .where((item) => item.building.branch == branchToRecenter)
            .toList();
        final dataMatchesSelectedBranch = value.whereType<BuildingItem>().every(
          (item) => item.building.branch == branchToRecenter,
        );

        if (!dataMatchesSelectedBranch || buildings.isEmpty) return null;

        pendingBranchRecenter.value = null;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          unawaited(
            ref
                .read(mapControllerProvider)
                .zoomOnItems(
                  buildings,
                  padding: const EdgeInsets.fromLTRB(56, 100, 56, 120),
                  maxZoom: MapWidgetConfig.defaultMarkerZoom - 2,
                  singleItemZoom: MapWidgetConfig.defaultMarkerZoom - 2,
                ),
          );
        });
      default:
        return null;
    }
    return null;
  }, [sourceState, pendingBranchRecenter.value]);
}
