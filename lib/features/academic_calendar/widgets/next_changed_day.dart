import "package:flutter/material.dart";
import "../../../theme/app_theme.dart";
import "../../../widgets/my_splash_tile.dart";

class NextChangedDay extends StatelessWidget {
  const NextChangedDay({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: MySplashTile(
        backgroundColor: Colors.transparent,
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [context.colorTheme.orangePomegranadeLighter, context.colorTheme.orangePomegranade],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: context.colorTheme.orangePomegranade.withValues(alpha: 0.15),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.warning_amber, size: 18, color: context.colorTheme.whiteSoap),
                    const SizedBox(width: 6),
                    Text(
                      "17 dni",
                      style: context.textTheme.bodyWhite.copyWith(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Text(
                "Nadchodzące 3 zmiany dnia!",
                style: context.textTheme.body.copyWith(fontWeight: FontWeight.w500, fontSize: 15),
              ),
              const SizedBox(width: 6),
              Icon(Icons.info_outline, size: 18, color: context.colorTheme.greyPigeon),
            ],
          ),
        ),
      ),
    );
  }
}
