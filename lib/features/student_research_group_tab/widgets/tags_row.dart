import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../config.dart';
import '../../../theme/app_theme.dart';
import '../../../utils/context_extensions.dart';
import '../repositories/selected_tag_controller.dart';
import '../repositories/tags_repository.dart';

class TagsRow extends ConsumerWidget {
  final List<Tag> allTags;
  const TagsRow({super.key, required this.allTags});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String selectedTag =
        ref.watch(selectedTagControllerProvider) ?? context.localize!.all;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
          padding: const EdgeInsets.only(
              left: ScientificCirclesTabConfig.smallPadding,
              right: ScientificCirclesTabConfig.smallPadding,
              bottom: ScientificCirclesTabConfig.smallPadding),
          child: Row(children: [
            for (final tag in allTags)
              _TagsRowItem(tag: tag, selectedTag: selectedTag),
          ])),
    );
  }
}

class _TagsRowItem extends ConsumerWidget {
  const _TagsRowItem({required this.tag, required this.selectedTag});

  final Tag tag;
  final String selectedTag;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: ScientificCirclesTabConfig.microPadding),
        child: ChoiceChip(
          showCheckmark: false,
          label: Text(tag.name ?? ""),
          selected: selectedTag == tag.name,
          onSelected: (bool selected) {
            ref
                .read(selectedTagControllerProvider.notifier)
                .handleTagSelected(tag);
          },
          selectedColor: context.colorTheme.blueAzure,
          backgroundColor: Colors.transparent,
          labelStyle: TextStyle(
              color: selectedTag == tag.name!
                  ? Colors.white
                  : context.colorTheme.blueAzure),
          side: BorderSide(color: context.colorTheme.blueAzure),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  ScientificCirclesTabConfig.buttonBorderRadius)),
        ));
  }
}
