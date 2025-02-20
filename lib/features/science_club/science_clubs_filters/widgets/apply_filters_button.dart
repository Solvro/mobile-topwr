import "package:flutter/material.dart";

import "../../../../config/ui_config.dart";
import "../../../../theme/app_theme.dart";
import "../../../../utils/context_extensions.dart";

class ApplyFiltersButton extends StatelessWidget {
  const ApplyFiltersButton({
    super.key,
    required this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: context.colorTheme.orangePomegranade,
          elevation: 4,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          shape: RoundedRectangleBorder(
            borderRadius:
                FilterConfig.radius, // Change this value to adjust the radius
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              width: 5,
            ),
            Text(
              context.localize.apply,
              style: context.textTheme.titleWhite,
            ),
            const SizedBox(
              width: 5,
            ),
            Icon(
              Icons.check,
              color: context.colorTheme.whiteSoap,
            ),
          ],
        ),
      ),
    );
  }
}
