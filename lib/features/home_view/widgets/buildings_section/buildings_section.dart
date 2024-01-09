import 'package:flutter/cupertino.dart';

import '../../../../utils/context_extensions.dart';
import '../section_header.dart';
import 'building_button.dart';

class BuildingsSection extends StatelessWidget {
  const BuildingsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SectionHeader(
          sectionTitle: context.localize!.buildings_title,
          buttonTitle: context.localize!.map_button,
          onPressed: () {
            print("Map clicked!");
          }),
      Padding(
        padding: const EdgeInsets.only(left: 24, top: 16),
        child: SizedBox(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 10,
            itemBuilder: (context, index) {
              return BuildingButton(
                onPressed: () {
                  print("Building button Clicked!");
                },
              );
            },
          ),
        ),
      )
    ]);
  }
}
