import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../config.dart';
import '../../repositories/scientific_circles/scientific_circles_repository.dart';
import '../../repositories/scientific_circles/tags_repository.dart';
import '../../theme/app_theme.dart';
import '../../utils/context_extensions.dart';
import '../../utils/where_non_null_iterable.dart';
import '../../widgets/my_error_widget.dart';
import '../../widgets/search_box_app_bar.dart';
import '../details_screen/study_circle_details.dart';
import 'scientific_circles_tab_controller.dart';
import 'widgets/scientific_circle_card.dart';
import 'widgets/scientific_circle_loading.dart';
import 'widgets/tags_loading.dart';

class ScientificCirclesTab extends ConsumerWidget {
  const ScientificCirclesTab({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: SearchBoxAppBar(
          context,
          title: context.localize?.study_circles ?? "",
          tagsBelow: true,
          onQueryChanged: (query) {
            ref
                .read(searchScientificCirclesControllerProvider.notifier)
                .onTextChanged(query);
          },
        ),
        body: const _ScientificCirclesBody());
  }
}

final selectedCategoryProvider = StateProvider<String?>((ref) => null);

class _ScientificCirclesBody extends ConsumerWidget {
  const _ScientificCirclesBody();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = ref.watch(tagsRepositoryProvider);
    final String selectedCategory =
        ref.watch(selectedCategoryProvider) ?? context.localize!.all;

    void handleCategorySelected(String category, WidgetRef ref) {
      ref.read(selectedCategoryProvider.notifier).state = category;
    }

    return Column(children: [
      SizedBox(
        height: 76.0,
        child: switch (categories) {
          AsyncLoading() => const TagsLoading(),
          AsyncError(:final error) => MyErrorWidget(error),
          AsyncValue(:final value) => _TagsDataView(
              handleTagSelected: handleCategorySelected,
              selectedTag: selectedCategory,
              allTags: value.whereNonNull.toList(),
            )
        },
      ),
      _ScientificCirclesListBody(selectedTag: selectedCategory)
    ]);
  }
}

class _TagsDataView extends ConsumerWidget {
  final void Function(String, WidgetRef) handleTagSelected;
  final String? selectedTag;
  final List<Tag> allTags;
  const _TagsDataView(
      {required this.handleTagSelected,
      required this.selectedTag,
      required this.allTags});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (allTags.isNotEmpty &&
        !allTags.contains(Tag(name: context.localize!.all))) {
      allTags.insert(0, Tag(name: context.localize!.all));
    }
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.only(
            left: ScientificCirclesTabConfig.smallPadding,
            right: ScientificCirclesTabConfig.smallPadding,
            bottom: ScientificCirclesTabConfig.smallPadding),
        child: Row(
          children: allTags
              .map(
                (category) => Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: ScientificCirclesTabConfig.microPadding),
                    child: ChoiceChip(
                      showCheckmark: false,
                      label: Text(category.name!),
                      selected: selectedTag == category.name,
                      onSelected: (bool selected) {
                        handleTagSelected(category.name!, ref);
                      },
                      selectedColor: context.colorTheme.blueAzure,
                      backgroundColor: Colors.transparent,
                      labelStyle: TextStyle(
                          color: selectedTag == category.name!
                              ? Colors.white
                              : context.colorTheme.blueAzure),
                      side: BorderSide(color: context.colorTheme.blueAzure),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              ScientificCirclesTabConfig.buttonBorderRadius)),
                    )),
              )
              .toList(),
        ),
      ),
    );
  }
}

class _ScientificCirclesListBody extends ConsumerWidget {
  final String? selectedTag;
  const _ScientificCirclesListBody({this.selectedTag});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(scientificCircleListProvider);
    return Expanded(
        child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: ScientificCirclesTabConfig.mediumPadding),
            child: switch (state) {
              AsyncLoading() => const ScientificCirclesLoading(),
              AsyncError(:final error) => MyErrorWidget(error),
              AsyncValue(:final value) => _ResearchGroupDataView(
                  value.whereNonNull.toList(), selectedTag),
            }));
  }
}

class _ResearchGroupDataView extends StatelessWidget {
  const _ResearchGroupDataView(this.scientificCircles, this.selectedCategory);

  final List<ScientificCircle> scientificCircles;
  final String? selectedCategory;

  @override
  Widget build(BuildContext context) {
    final filteredCircles = selectedCategory == context.localize!.all
        ? scientificCircles
        : scientificCircles.where((circle) {
            if (circle.tags != null) {
              for (var tag in circle.tags!) {
                if (tag!.name == selectedCategory) {
                  return true;
                }
              }
            }
            return false;
          }).toList();
    if (filteredCircles.isEmpty) {
      return Center(
        child: Text(
          context.localize?.sci_circle_not_found ?? "",
          style: context.textTheme.body,
        ),
      );
    }
    return GridView.builder(
      padding: const EdgeInsets.only(
          bottom: ScientificCirclesTabConfig.mediumPadding),
      gridDelegate: ScientificCirclesTabConfig.researchGroupTabGridDelegate,
      itemCount: filteredCircles.length,
      itemBuilder: (context, index) =>
          ResearchGroupCard(filteredCircles[index], () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const StudyCircleDetails(),
              settings: RouteSettings(
                arguments: filteredCircles[index].id,
              ),
            ));
      }),
    );
  }
}
