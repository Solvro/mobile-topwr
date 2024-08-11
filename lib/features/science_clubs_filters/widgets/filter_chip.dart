import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../config/ui_config.dart";
import "../../../theme/app_theme.dart";

class MyFilterChip extends ConsumerWidget {
  const MyFilterChip({
    required this.label,
    required this.selected,
    required this.onTap,
    this.selectedColor,
    this.selectedBorderColor,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;
  final Color? selectedColor;
  final Color? selectedBorderColor;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: ScienceClubsViewConfig.microPadding,
      ),
      child: ChoiceChip(
        showCheckmark: false,
        label: Text(label),
        selected: selected,
        onSelected: (_) => onTap(),
        selectedColor: selectedColor ?? context.colorTheme.orangePomegranade,
        backgroundColor: Colors.transparent,
        labelStyle: TextStyle(
          color: selected ? Colors.white : context.colorTheme.greyPigeon,
        ),
        side: BorderSide(
          color: selected
              ? selectedBorderColor ?? context.colorTheme.orangePomegranade
              : context.colorTheme.greyPigeon,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            ScienceClubsViewConfig.buttonBorderRadius,
          ),
        ),
      ),
    );
  }
}
