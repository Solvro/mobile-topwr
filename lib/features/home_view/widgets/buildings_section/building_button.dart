import 'package:flutter/material.dart';

import '../../../../theme/app_theme.dart';
import '../../../../theme/hex_color.dart';

class BuildingButton extends StatelessWidget {
  const BuildingButton({Key? key, required this.onPressed}) : super(key: key);
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 16),
      width: 120,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Stack(
          children: [
            Image.asset(
              'assets/placeholder/c13.png',
              fit: BoxFit.cover,
            ),
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  gradient: context.colorTheme.buildingsGradient,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 16, top: 84),
              child: Text("C-13",
                  style: context.textTheme.headlineWhite.copyWith(shadows: [
                    const Shadow(
                      color: HexColor.consts(0x6621334D66),
                      blurRadius: 4.0,
                      offset: Offset(0.0, 2.0),
                    ),
                  ])),
            ),
            Material(
              borderRadius: BorderRadius.circular(8.0),
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(8.0),
                onTap: onPressed,
                child: Container(
                  color: Colors.transparent,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
