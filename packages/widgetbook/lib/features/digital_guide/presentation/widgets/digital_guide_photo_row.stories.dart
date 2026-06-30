import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/widgets.dart";
import "package:topwr/features/digital_guide/presentation/widgets/digital_guide_photo_row.dart";
import "package:widgetbook/widgetbook.dart";

part "digital_guide_photo_row.stories.g.dart";

final _mockImagesIDs = IList<int>(const [101, 102, 103]);

const meta = Meta(DigitalGuidePhotoRow.new);

final $default = DigitalGuidePhotoRowStory(args: DigitalGuidePhotoRowArgs(imagesIDs: Arg.fixed(_mockImagesIDs)));
