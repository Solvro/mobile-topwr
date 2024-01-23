import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../config.dart';
import '../theme/app_theme.dart';
import '../utils/context_extensions.dart';
import 'date_chip.dart';

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
      width: 240,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 145,
            child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(8)),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: CachedNetworkImageProvider(
                          photoUrl ?? BigPreviewCardConfig.placeHolderUrl)),
                ),
                child: date != null
                    ? DateChip(date: date!)
                    : const SizedBox.shrink()),
          ),
          Expanded(
            flex: 215,
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    title,
                    style: context.textTheme.title,
                  ),
                  Text(
                    shortDescription,
                    maxLines: 5,
                    style: context.textTheme.body,
                    overflow: TextOverflow.ellipsis,
                  ),
                  MaterialButton(
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
