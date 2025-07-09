import "package:flutter/material.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "../../../../config/ui_config.dart";
import "../../../../hooks/use_semantics_service_on_changed_value.dart";
import "../../../../theme/app_theme.dart";
import "../../../../utils/context_extensions.dart";

class MyFilterChip extends HookConsumerWidget {
  const MyFilterChip({
    required this.label,
    required this.selected,
    required this.onTap,
    this.selectedColor,
    this.selectedBorderColor,
    this.tooltip,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;
  final Color? selectedColor;
  final Color? selectedBorderColor;
  final String? tooltip;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useSemanticsServiceOnChangedValue(
      selected,
      messageBuilder: (value) => value ? null : "${context.localize.building_tile_unselected} $label",
    );
    return Theme(
      data: Theme.of(
        context,
      ).copyWith(colorScheme: ColorScheme.fromSeed(seedColor: context.colorTheme.orangePomegranade)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: ScienceClubsViewConfig.microPadding),
        child: Semantics(
          checked: selected,
          child: ChoiceChip(
            tooltip: tooltip ?? label,
            showCheckmark: false,
            label: Text(label),
            selected: selected,
            onSelected: (_) => onTap(),
            selectedColor: selectedColor ?? context.colorTheme.orangePomegranade,
            backgroundColor: Colors.transparent,
            labelStyle: TextStyle(color: selected ? Colors.white : context.colorTheme.greyPigeon),
            side: BorderSide(
              color: selected
                  ? selectedBorderColor ?? context.colorTheme.orangePomegranade
                  : context.colorTheme.greyPigeon,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(ScienceClubsViewConfig.buttonBorderRadius),
            ),
          ),
        ),
      ),
    );
  }
}
