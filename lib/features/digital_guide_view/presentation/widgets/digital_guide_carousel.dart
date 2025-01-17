import "dart:async";

import "package:carousel_slider_plus/carousel_slider_plus.dart";
import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";

import "../../../../config/ui_config.dart";
import "digital_guide_image.dart";

class DigitalGuideCarouselWithIndicator extends StatefulWidget {
  const DigitalGuideCarouselWithIndicator({super.key, required this.imgListId});

  final IList<int> imgListId;

  @override
  State<StatefulWidget> createState() {
    return _CarouselWithIndicatorState();
  }
}

class _CarouselWithIndicatorState
    extends State<DigitalGuideCarouselWithIndicator> {
  int _current = 0;
  final CarouselSliderController _controller = CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      child: Wrap(
        children: [
          CarouselSlider(
            items: widget.imgListId
                .map(
                  (item) => ClipRRect(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(DigitalGuideConfig.borderRadiusMedium),
                    ),
                    child: DigitalGuideImage(id: item),
                  ),
                )
                .toList(),
            controller: _controller,
            options: CarouselOptions(
              autoPlay: true,
              enlargeCenterPage: true,
              onPageChanged: (index, reason) {
                setState(() => _current = index);
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: widget.imgListId.asMap().entries.map((entry) {
              return GestureDetector(
                onTap: () => unawaited(_controller.animateToPage(entry.key)),
                child: Container(
                  width: 12,
                  height: 12,
                  margin: const EdgeInsets.symmetric(
                    vertical: DigitalGuideConfig.heightMedium,
                    horizontal: 4,
                  ),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black
                        .withAlpha(_current == entry.key ? 230 : 102),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
