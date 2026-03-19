import "package:flutter/widgets.dart";
import "package:topwr/theme/colors.dart";
import "package:topwr/widgets/wide_tile_card.dart";
import "package:widgetbook/widgetbook.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: WideTileCard)
Widget useCaseWideTileCard(BuildContext context) {
  final gradientOptions = <LinearGradient>[
    ColorsConsts.toPwrGradient,
    ColorsConsts.buildingsGradient,
  ];

  final shadowOptions = <List<BoxShadow>>[
    const [
      BoxShadow(color: Color(0x33000000), blurRadius: 16, offset: Offset(0, 8)),
    ],
    const [
      BoxShadow(color: Color(0x2A000000), blurRadius: 12, offset: Offset(0, 6)),
      BoxShadow(color: Color(0x1A000000), blurRadius: 4, offset: Offset(0, 2)),
    ],
  ];

  return WideTileCard(
    title: context.knobs.string(label: "Title", initialValue: "Main building"),
    subtitle: context.knobs.string(label: "Subtitle", initialValue: "Open now - 2 min walk"),
    trailing: const SizedBox(width: 100, height: 100),
    onTap: () {},
    activeGradient: context.knobs.objectOrNull.dropdown(label: "Active gradient", options: gradientOptions),
    isActive: context.knobs.boolean(label: "Is active"),
    activeShadows: context.knobs.objectOrNull.dropdown(label: "Active shadows", options: shadowOptions),
    crossAxisAlignment: context.knobs.object.dropdown(
      label: "Cross axis alignment",
      options: CrossAxisAlignment.values,
    ),
    showBadge: context.knobs.boolean(label: "Show badge"),
    showStrategicBadge: context.knobs.boolean(label: "Show strategic badge"),
    fixedTrailingHeight: context.knobs.boolean(label: "Fixed trailing height"),
  );
}
