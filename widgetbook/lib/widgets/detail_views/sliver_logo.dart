import "package:flutter/widgets.dart";
import "package:topwr/widgets/detail_views/sliver_logo.dart";
import "package:topwr/widgets/my_cached_image.dart";
import "package:widgetbook/widgetbook.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: SliverLogo)
Widget useCaseSliverLogo(BuildContext context) {
  const gradients = <LinearGradient>[
    LinearGradient(colors: [Color(0xFF6A11CB), Color(0xFF2575FC)]),
    LinearGradient(colors: [Color(0xFFF2994A), Color(0xFFF2C94C)]),
  ];

  return SliverLogo(
    logoSize: context.knobs.double.input(label: "Logo size", initialValue: 120),
    logoOpacity: context.knobs.double.input(label: "Logo opacity", initialValue: 1),
    scaleFactor: context.knobs.double.input(label: "Scale factor", initialValue: 0.9),
    activeGradient: context.knobs.objectOrNull.dropdown(
      label: "Active gradient",
      options: gradients,
      initialOption: gradients.first,
    ),
    logoDirectusUrl: context.knobs.string(
      label: "Logo directus url",
      initialValue: "https://placehold.co/512x512/png",
    ),
    boxfit: context.knobs.object.dropdown(
      label: "Boxfit",
      options: BoxFit.values,
      initialOption: BoxFit.contain,
    ),
    loadingType: context.knobs.object.dropdown(
      label: "Loading type",
      options: LoadingType.values,
      initialOption: LoadingType.shimmerLoading,
    ),
  );
}
