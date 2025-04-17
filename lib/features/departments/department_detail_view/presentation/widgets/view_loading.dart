import "package:flutter/material.dart";

import "../../../../../config/ui_config.dart";
import "../../../../../widgets/loading_widgets/contact_section_loading.dart";
import "../../../../../widgets/loading_widgets/header_section_loading.dart";
import "../../../../../widgets/loading_widgets/shimmer_loading.dart";
import "../../../../home_view/widgets/loading_widgets/big_scrollable_section_loading.dart";

class DepartmentDetailViewLoading extends StatelessWidget {
  const DepartmentDetailViewLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      linearGradient: shimmerGradient,
      child: ListView(
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          HeaderSectionLoading(),
          SizedBox(height: DetailViewsConfig.spacerHeight),
          ContactSectionLoading(),
          SizedBox(height: DetailViewsConfig.spacerHeight),
          BigScrollableSectionLoading(crossAxisForcedSize: 400),
        ],
      ),
    );
  }
}
