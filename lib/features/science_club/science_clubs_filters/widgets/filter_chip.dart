import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../../config/ui_config.dart";
import "../../../../services/translations_service/widgets/text_with_translation.dart";
import "../../../../theme/app_theme.dart";

class MyFilterChip extends ConsumerWidget {
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
    return Theme(
      data: Theme.of(
        context,
      ).copyWith(colorScheme: ColorScheme.fromSeed(seedColor: context.colorTheme.orangePomegranade)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: ScienceClubsViewConfig.microPadding),
        child: ChoiceChip(
          tooltip: tooltip ?? label,
          showCheckmark: false,
          label: TextWithTranslation(label),
          selected: selected,
          onSelected: (_) => onTap(),
          selectedColor: selectedColor ?? context.colorTheme.orangePomegranade,
          backgroundColor: Colors.transparent,
          labelStyle: TextStyle(color: selected ? Colors.white : context.colorTheme.greyPigeon),
          side: BorderSide(
            color:
                selected ? selectedBorderColor ?? context.colorTheme.orangePomegranade : context.colorTheme.greyPigeon,
          ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(ScienceClubsViewConfig.buttonBorderRadius)),
        ),
      ),
    );
  }
}
