import "dart:async";

import "package:carousel_slider_plus/carousel_slider_plus.dart";
import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";

import "../../../../config/ui_config.dart";
import "../../../../theme/app_theme.dart";
import "../../../../utils/context_extensions.dart";
import "../../../../widgets/arrow_button.dart";
import "digital_guide_image.dart";

class DigitalGuideCarouselWithIndicator extends HookWidget {
  const DigitalGuideCarouselWithIndicator({super.key, required this.imgListId, this.initId});

  final IList<int> imgListId;
  final int? initId;

  @override
  Widget build(BuildContext context) {
    final current = useState(initId != null ? imgListId.indexOf(initId!) : 0);
    final shouldAutoplay = useState(true);
    final controller = useMemoized(CarouselSliderController.new);

    Future<void> goTo(int index) async {
      if (imgListId.isEmpty) return;
      // wrap index into range [0 - length-1] for the coursel to loop
      // (for positive length the result is non-negative, eg. -1 % 3 ---> 2)
      final wrapped = index % imgListId.length;
      await controller.animateToPage(wrapped);
    }

    return Dialog(
      insetPadding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CarouselSlider(
            items: imgListId
                .map(
                  (item) => InteractiveViewer(
                    minScale: 1,
                    maxScale: 5,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(DigitalGuideConfig.borderRadiusMedium)),
                      child: DigitalGuideImage(id: item, zoomable: false),
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
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ArrowButton(icon: Icons.chevron_left, onPressed: () => unawaited(goTo(current.value - 1))),

                Row(
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

                ArrowButton(icon: Icons.chevron_right, onPressed: () => unawaited(goTo(current.value + 1))),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: DigitalGuideConfig.paddingBig,
            children: [
              Text(
                shouldAutoplay.value ? context.localize.autoplay_enabled : context.localize.autoplay_disabled,
                style: context.textTheme.titleLarge?.copyWith(color: context.colorScheme.surface),
              ),
              Switch(
                value: shouldAutoplay.value,
                trackColor: WidgetStateProperty.all(
                  shouldAutoplay.value ? context.colorScheme.primaryContainer : context.colorScheme.surface,
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
