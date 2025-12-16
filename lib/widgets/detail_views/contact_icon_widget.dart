import "package:flutter/material.dart";
import "package:flutter_svg/svg.dart";
import "../../theme/app_theme.dart";
import "../../utils/context_extensions.dart";

class ContactIconWidget extends StatelessWidget {
  const ContactIconWidget({super.key, required this.icon});

  final String icon;

  @override
  Widget build(BuildContext context) {
    final scaler = context.textScaler.clamp(minScaleFactor: 0.9, maxScaleFactor: 1.5);
    return Material(
      borderRadius: BorderRadius.circular(4),
      elevation: 2,
      child: ClipOval(
        child: Container(
          width: scaler.scale(35),
          height: scaler.scale(35),
          color: context.colorScheme.surface,
          child: Center(
            child: SizedBox(
              width: scaler.scale(20),
              height: scaler.scale(20),
              child: SvgPicture.asset(icon, fit: BoxFit.fitWidth),
            ),
          ),
        ),
      ),
    );
  }
}
