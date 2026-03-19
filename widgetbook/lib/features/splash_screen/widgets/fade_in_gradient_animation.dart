import "package:flutter/material.dart";
import "package:topwr/features/splash_screen/widgets/fade_in_gradient_animation.dart";
import "package:widgetbook/widgetbook.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: FadeInGradientAnimation)
Widget useCaseFadeInGradientAnimation(BuildContext context) {
  return FadeInGradientAnimation(
    gradientStart: context.knobs.object.dropdown(
      label: "Gradient start",
      options: [
        const LinearGradient(colors: [Colors.blue, Colors.purple]),
        const LinearGradient(colors: [Colors.red, Colors.orange]),
      ],
    ),
    gradientStop: context.knobs.object.dropdown(
      label: "Gradient stop",
      options: [
        const LinearGradient(colors: [Colors.purple, Colors.pink]),
        const LinearGradient(colors: [Colors.orange, Colors.yellow]),
      ],
    ),
    duration: context.knobs.duration(label: "Duration"),
  );
}
