import 'package:flutter/material.dart';
import '../config.dart';
import '../theme/app_theme.dart';
import '../utils/context_extensions.dart';
import 'date_chip.dart';
import 'my_cached_image.dart';

class BigPreviewCard extends StatelessWidget {
  const BigPreviewCard({
    super.key,
    required this.title,
    required this.shortDescription,
    required this.photoUrl,
    this.date,
    required this.onClick,
  });

  final String title;
  final String shortDescription;
  final String? photoUrl;
  final DateTime? date;
  final void Function() onClick;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: context.colorTheme.greyLight,
          borderRadius: BorderRadius.circular(8)),
      width: BigPreviewCardConfig.cardWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              flex: 135,
              child: ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(8)),
                child: Stack(
                  alignment: Alignment.topRight,
                  children: [
                    MyCachedImage(photoUrl),
                    date != null
                        ? DateChip(date: date!)
                        : const SizedBox.shrink()
                  ],
                ),
              )),
          Expanded(
            flex: 210,
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  RichText(
                    maxLines: 8,
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(children: [
                      TextSpan(
                        text: "$title\n",
                        style: context.textTheme.title,
                      ),
                      const TextSpan(
                        text: "\n", // padding workaround
                        style: TextStyle(fontSize: 7, height: 1),
                      ),
                      TextSpan(
                        text: shortDescription,
                        style: context.textTheme.body,
                      ),
                    ]),
                  ),
                  const Spacer(),
                  MaterialButton(
                    elevation: 1,
                    padding: const EdgeInsets.all(8),
                    onPressed: onClick,
                    color: context.colorTheme.orangePomegranade,
                    textColor: context.colorTheme.whiteSoap,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4)),
                    child: Text(context.localize!.read_more),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
