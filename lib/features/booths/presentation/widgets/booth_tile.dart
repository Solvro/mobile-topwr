import "package:flutter/material.dart";

import "../../../../config/ui_config.dart";
import "../../../../theme/app_theme.dart";
import "../../../../theme/iparking_theme.dart";
import "../../../../utils/context_extensions.dart";
import "../../../radio_luz/presentation/live_indicator.dart";
import "../../data/models/booth.dart";

abstract class BoothTileConfig {
  static const height = 132.0;
}

class BoothTile extends StatelessWidget {
  const BoothTile(this.booth, {super.key});

  final Booth booth;

  @override
  Widget build(BuildContext context) {
    final scaler = context.textScaler.clamp(maxScaleFactor: 2);
    final statusText = booth.status.localizedName(context.localize);
    final statusColor = booth.status.color(context);

    return Semantics(
      label: "${booth.name}. ${booth.localization}. ${context.localize.booth_status}: $statusText",
      child: Container(
        height: scaler.scale(BoothTileConfig.height),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(WideTileCardConfig.radius),
          image: booth.displayPhotoUrl.isEmpty
              ? null
              : DecorationImage(fit: BoxFit.cover, image: NetworkImage(booth.displayPhotoUrl)),
          color: context.colorScheme.primaryContainer,
        ),
        foregroundDecoration: BoxDecoration(
          borderRadius: const BorderRadius.all(WideTileCardConfig.radius),
          border: Border.all(color: statusColor, width: 1.5),
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [Color.fromRGBO(41, 50, 65, 0.78), Color.fromRGBO(41, 50, 65, 0.46)]),
              ),
              child: SizedBox.expand(),
            ),
            Container(
              width: double.infinity,
              padding: ParkingsConfig.padding.copyWith(right: scaler.scale(118), bottom: scaler.scale(16)),
              child: _LeftColumn(booth),
            ),
            Container(width: double.infinity, padding: ParkingsConfig.padding, child: _RightColumn(booth.status)),
          ],
        ),
      ),
    );
  }
}

class _LeftColumn extends StatelessWidget {
  const _LeftColumn(this.booth);

  final Booth booth;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(booth.name, style: const ParkingTitleTextStyle(), maxLines: 2, overflow: TextOverflow.ellipsis),
        const Spacer(),
        Padding(
          padding: ParkingsConfig.extraIndentPadd,
          child: Text(
            booth.localization,
            style: const ParkingSubtitleTextStyle(),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

class _RightColumn extends StatelessWidget {
  const _RightColumn(this.status);

  final BoothStatus status;

  @override
  Widget build(BuildContext context) {
    final color = status.color(context);
    final scaler = context.textScaler.clamp(maxScaleFactor: 2);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const Spacer(),
        Semantics(
          label: "${context.localize.booth_status}: ${status.localizedName(context.localize)}",
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.78),
              borderRadius: BorderRadius.circular(999),
              border: Border.all(color: Colors.white.withValues(alpha: 0.34)),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ExcludeSemantics(
                    child: Text(
                      status.localizedName(context.localize),
                      style: ParkingSubtitleTextStyle(color: color).withoutShadows,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(width: scaler.scale(7)),
                  _StatusDot(status: status, color: color),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _StatusDot extends StatelessWidget {
  const _StatusDot({required this.status, required this.color});

  final BoothStatus status;
  final Color color;

  @override
  Widget build(BuildContext context) {
    if (status == BoothStatus.offline) {
      return _Dot(color: color);
    }

    return LiveIndicator(
      radius: 4.5,
      spreadRadius: 5.5,
      color: color,
      spreadDuration: const Duration(milliseconds: 1300),
      waitDuration: const Duration(milliseconds: 700),
    );
  }
}

class _Dot extends StatelessWidget {
  const _Dot({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 11,
      height: 11,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        border: Border.all(color: Colors.white.withValues(alpha: 0.34), width: 1.5),
        boxShadow: [BoxShadow(color: color.withValues(alpha: 0.35), blurRadius: 6)],
      ),
    );
  }
}
