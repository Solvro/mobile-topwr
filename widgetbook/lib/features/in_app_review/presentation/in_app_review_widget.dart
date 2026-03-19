import "package:flutter/widgets.dart";
import "package:topwr/features/in_app_review/presentation/in_app_review.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: InAppReviewWidget)
Widget useCaseInAppReviewWidget(BuildContext context) {
  return const InAppReviewWidget(child: SizedBox(width: 100, height: 100));
}
