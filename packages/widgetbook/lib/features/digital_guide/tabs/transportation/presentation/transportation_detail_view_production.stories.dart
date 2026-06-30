import "package:flutter/widgets.dart";
import "package:topwr/features/digital_guide/tabs/transportation/presentation/transportation_detail_view.dart";
import "package:widgetbook/widgetbook.dart";

import "../../../../../widgetbook_mocks.dart";

part "transportation_detail_view_production.stories.g.dart";

class TransportationDetailViewProductionStory extends StatelessWidget {
  const TransportationDetailViewProductionStory({super.key});

  @override
  Widget build(BuildContext context) {
    return const TransportationDetailView(transportation: mockDigitalGuideTransportationC13, isPublic: true);
  }
}

const meta = Meta(TransportationDetailViewProductionStory.new);

final $fromProduction = TransportationDetailViewProductionStoryStory(name: "Hardcoded production snapshot");
