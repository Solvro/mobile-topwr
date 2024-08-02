import "package:flutter/material.dart";
import "package:flutter_svg/svg.dart";
import "../../theme/app_theme.dart";

class ContactIconWidget extends StatelessWidget {
  const ContactIconWidget({
    super.key,
    required this.icon,
  });

  final String icon;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(4),
      elevation: 2,
      child: ClipOval(
        child: Container(
          width: 35,
          height: 35,
          color: context.colorTheme.whiteSoap,
          child: Center(
            child: SizedBox(
              width: 20,
              child: SvgPicture.asset(
                icon,
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
