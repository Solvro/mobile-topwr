import "package:flutter/material.dart";

import "../business/top_level_modes.dart";
import "../data/modes.dart";
import "mode_checkbox.dart";

class _SubModePadding extends Padding {
  const _SubModePadding({super.child}) : super(padding: const EdgeInsets.only(left: 25));
}

class CheckboxesList extends StatelessWidget {
  const CheckboxesList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (final mode in topLevelModes)
          switch (mode) {
            ModeWithChildren() => Column(
              children: [
                ModeCheckbox(mode),
                for (final subMode in mode.children) _SubModePadding(child: ModeCheckbox(subMode)),
              ],
            ),
            ModeWithKey() => ModeCheckbox(mode),
          },
      ],
    );
  }
}
