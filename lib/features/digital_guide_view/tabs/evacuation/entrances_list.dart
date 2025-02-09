import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../../config/ui_config.dart";
import "../../../../widgets/my_error_widget.dart";
import "../../data/models/digital_guide_response.dart";
import "../../presentation/widgets/digital_guide_nav_link.dart";
import "../entraces/data/models/digital_guide_entrace.dart";
import "../entraces/data/repository/entraces_repository.dart";

class EntrancesList extends ConsumerWidget {
  const EntrancesList(this.digitalGuideData, {super.key});
  final DigitalGuideResponse digitalGuideData;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final entrances = ref.watch(entrancesRepositoryProvider(digitalGuideData));
    return entrances.when(
      data: (entrancesData) => ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) => DigitalGuideNavLink(
          onTap: () {},
          text: toNonNullString(entrancesData[index].translations.pl.name),
        ),
        separatorBuilder: (context, index) => const SizedBox(
          height: DigitalGuideConfig.heightMedium,
        ),
        itemCount: entrancesData.length,
        shrinkWrap: true,
      ),
      error: (error, stackTrace) => MyErrorWidget(error),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
