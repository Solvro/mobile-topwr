import "package:flutter/widgets.dart";
import "package:topwr/api_base_rest/shared_models/image_data.dart";
import "package:topwr/features/guide_view/data/models/guide_data.dart";
import "package:topwr/features/guide_view/widgets/guide_tile.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

const _mockImageData = ImageData(url: "https://example.com/image.png");

const _mockGuideData = GuideData(
  id: 1,
  title: "Guide Title",
  shortDesc: "This is a short description of the guide.",
  image: _mockImageData,
);

@widgetbook.UseCase(name: "default", type: GuideTile)
Widget useCaseGuideTile(BuildContext context) {
  return const GuideTile(_mockGuideData);
}
