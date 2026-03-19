import "package:flutter/widgets.dart";
import "package:topwr/features/radio_luz/presentation/audition_image_fallback.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: AuditionImageFallback)
Widget useCaseAuditionImageFallback(BuildContext context) {
  return const AuditionImageFallback();
}
