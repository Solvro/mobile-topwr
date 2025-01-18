import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../../../config/ui_config.dart";
import "../../../../../theme/app_theme.dart";
import "../../../../navigator/utils/navigation_commands.dart";
import "../../../data/models/level.dart";
import "../../../presentation/widgets/digital_guide_nav_link.dart";
import "../data/models/digital_guide_room.dart";

class DigitalGuideRoomLevel extends ConsumerWidget {
  const DigitalGuideRoomLevel(
      {super.key, required this.level, required this.rooms,});

  final Level level;
  final IList<DigitalGuideRoom> rooms;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          level.translations.plTranslation.name,
          style: context.textTheme.lightTitle,
        ),
        const SizedBox(height: 10),
        ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) => DigitalGuideNavLink(
            onTap: () async {
              await ref.navigateRoomDetails(
                rooms[index],
              );
            },
            text: rooms[index].translations.pl.name,
          ),
          separatorBuilder: (context, index) => const SizedBox(
            height: DigitalGuideConfig.heightMedium,
          ),
          itemCount: rooms.length,
          shrinkWrap: true,
        ),
        const SizedBox(
          height: DigitalGuideConfig.heightMedium,
        ),
      ],
    );
  }
}
