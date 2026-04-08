import "package:topwr/features/multilayer_map/data/model/multilayer_section_type.dart";
import "package:topwr/features/multilayer_map/presentation/views/multilayer_map_view.dart";
import "package:widgetbook/widgetbook.dart";

part "multilayer_map_view.stories.g.dart";

class MultilayerMapViewStoryKnobs {
  final String? initialActiveItemId;
  final MultilayerSectionType? initialSectionType;
  MultilayerMapViewStoryKnobs({this.initialActiveItemId, this.initialSectionType});
}

const meta = MetaWithArgs<MultilayerMapView, MultilayerMapViewStoryKnobs>();

final defaults = _Defaults(
  builder: (context, args) =>
      MultilayerMapView(initialActiveItemId: args.initialActiveItemId, initialSectionType: args.initialSectionType),
);

final $default = MultilayerMapViewStory();
