import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/widgets.dart";
import "package:topwr/features/digital_guide/presentation/widgets/digital_guide_photo_row.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

final _mockImagesIDs = IList<int>(const [101, 102, 103]);

@widgetbook.UseCase(name: "default", type: DigitalGuidePhotoRow)
Widget useCaseDigitalGuidePhotoRow(BuildContext context) {
  return DigitalGuidePhotoRow(imagesIDs: _mockImagesIDs);
}
