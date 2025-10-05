import "dart:async";

import "package:carousel_slider_plus/carousel_slider_plus.dart";
import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";

import "../../../../config/ui_config.dart";
import "../../../../theme/app_theme.dart";
import "../../../../theme/colors.dart";
import "../../../../utils/context_extensions.dart";
import "digital_guide_image.dart";

class DigitalGuideCarouselWithIndicator extends HookWidget {
  const DigitalGuideCarouselWithIndicator({
    super.key,
    required this.imgListId,
    this.initId,
    required this.semanticsLabel,
  });

  final IList<int> imgListId;
  final int? initId;
  final String semanticsLabel;

  @override
  Widget build(BuildContext context) {
    final current = useState(initId != null ? imgListId.indexOf(initId!) : 0);
    final shouldAutoplay = useState(true);
    final controller = useMemoized(CarouselSliderController.new);

    return Dialog(
      insetPadding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      child: Wrap(
        children: [
          CarouselSlider(
            items: imgListId
                .map(
                  (item) => InteractiveViewer(
                    minScale: 1,
                    maxScale: 5,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(DigitalGuideConfig.borderRadiusMedium)),
                      child: DigitalGuideImage(id: item, zoomable: false, semanticsLabel: semanticsLabel),
                    ),
                  ),
                )
                .toList(),
            controller: controller,
            options: CarouselOptions(
              initialPage: current.value,
              autoPlay: shouldAutoplay.value,
              enlargeCenterPage: true,
              onPageChanged: (index, reason) {
                current.value = index;
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: imgListId.asMap().entries.map((entry) {
              return GestureDetector(
                onTap: () => unawaited(controller.animateToPage(entry.key)),
                child: Container(
                  width: 12,
                  height: 12,
                  margin: const EdgeInsets.symmetric(vertical: DigitalGuideConfig.heightMedium, horizontal: 4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black.withAlpha(current.value == entry.key ? 230 : 102),
                    border: Border.all(color: Colors.white),
                  ),
                ),
              );
            }).toList(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: DigitalGuideConfig.paddingBig,
            children: [
              Text(
                shouldAutoplay.value ? context.localize.autoplay_enabled : context.localize.autoplay_disabled,
                style: context.textTheme.titleWhite,
              ),
              Switch(
                value: shouldAutoplay.value,
                trackColor: WidgetStateProperty.all(
                  shouldAutoplay.value ? ColorsConsts.orangePomegranadeLighter : ColorsConsts.whiteSoap,
                ),
                onChanged: (newShouldAutoplay) {
                  shouldAutoplay.value = newShouldAutoplay;
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
