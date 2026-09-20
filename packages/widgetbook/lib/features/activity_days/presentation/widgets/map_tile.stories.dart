import "package:topwr/features/activity_days/data/models/activity_days_response.dart";
import "package:topwr/features/activity_days/presentation/widgets/map_tile.dart";
import "package:widgetbook/widgetbook.dart";

part "map_tile.stories.g.dart";

const _map = ActivityDaysMap(id: 1, name: "Parter (C-13)", contentKey: "widgetbook-map");

class MapTileStoryKnobs {
  const MapTileStoryKnobs({required this.map});

  final ActivityDaysMap map;
}

const meta = Meta(MapTile.new, argsType: MapTileStoryKnobs.new);

final defaults = _Defaults(builder: (context, args) => MapTile(map: args.map));

final $default = MapTileStory(args: MapTileStoryKnobsArgs(map: Arg.fixed(_map)));
