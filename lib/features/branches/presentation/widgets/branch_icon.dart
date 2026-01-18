import "package:flutter/material.dart";
import "package:flutter_svg/svg.dart";

import "../../../../gen/assets.gen.dart";
import "../../../../theme/hex_color.dart";
import "../../data/model/branch.dart";

class BranchIcon extends StatelessWidget {
  const BranchIcon({super.key, required this.branch, required this.isEnabled});

  final Branch branch;
  final bool isEnabled;

  Color get branchColor => switch (branch) {
    Branch.main => HexColor("#B32216"),
    Branch.jeleniaGora => HexColor("#52419A"),
    Branch.walbrzych => HexColor("#883279"),
    Branch.legnica => HexColor("#00AE45"),
  };

  @override
  Widget build(BuildContext context) {
    final icon = SizedBox.square(
      dimension: 30,
      child: SvgPicture.asset(
        switch (branch) {
          Branch.main => Assets.svg.branchesLogos.logoPwr,
          Branch.jeleniaGora => Assets.svg.branchesLogos.logoJelenia,
          Branch.walbrzych => Assets.svg.branchesLogos.logoWalbrzych,
          Branch.legnica => Assets.svg.branchesLogos.logoLegnica,
        },
        height: 30,
        width: 30,
        colorFilter: branch == Branch.main ? null : ColorFilter.mode(branchColor, BlendMode.srcIn),
      ),
    );

    return SizedBox(
      height: 25,
      child: isEnabled
          ? DecoratedBox(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: branchColor.withValues(alpha: 0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: icon,
            )
          : icon,
    );
  }
}
