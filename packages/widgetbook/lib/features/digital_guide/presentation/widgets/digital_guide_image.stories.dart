import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:topwr/features/digital_guide/data/repository/image_repository.dart";
import "package:topwr/features/digital_guide/presentation/widgets/digital_guide_image.dart";
import "package:widgetbook/widgetbook.dart";

part "digital_guide_image.stories.g.dart";

const meta = Meta<DigitalGuideImage>();

final $default = DigitalGuideImageStory(
  setup: (context, child, args) => ProviderScope(
    overrides: [
      imageRepositoryProvider.overrideWith(
        (ref, imageID) async => "data:image/gif;base64,R0lGODlhAQABAAAAACw=",
      ),
    ],
    child: child,
  ),
);
