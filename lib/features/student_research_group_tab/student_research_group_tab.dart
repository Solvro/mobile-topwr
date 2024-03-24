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
import 'student_research_group_tab_controller.dart';
import 'widgets/research_group_card.dart';
import 'widgets/research_group_loading.dart';

class StudentResearchGroupTab extends ConsumerWidget {
  const StudentResearchGroupTab({
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
        body: const _CategoryList());
  }
}

final selectedCategoryProvider = StateProvider<String?>((ref) => null);

class _CategoryList extends ConsumerWidget {
  const _CategoryList();

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
          AsyncLoading() => const ResearchGroupLoading(),
          AsyncError(:final error) => MyErrorWidget(error),
          AsyncValue(:final value) => _TagsDataView(
              handleCategorySelected: handleCategorySelected,
              selectedCategory: selectedCategory,
              allCategories: value.whereNonNull.toList(),
            )
        },
      ),
      _ResearchGroupListBody(selectedTag: selectedCategory)
    ]);
  }
}

class _TagsDataView extends ConsumerWidget {
  final void Function(String, WidgetRef) handleCategorySelected;
  final String? selectedCategory;
  final List<Tag> allCategories;
  const _TagsDataView(
      {required this.handleCategorySelected,
      required this.selectedCategory,
      required this.allCategories});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (allCategories.isNotEmpty &&
        !allCategories.contains(Tag(name: context.localize!.all))) {
      allCategories.insert(0, Tag(name: context.localize!.all));
    }
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.only(
            left: ResearchGroupConfig.smallPadding,
            right: ResearchGroupConfig.smallPadding,
            bottom: ResearchGroupConfig.smallPadding),
        child: Row(
          children: allCategories
              .map(
                (category) => Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: ResearchGroupConfig.microPadding),
                    child: ChoiceChip(
                      showCheckmark: false,
                      label: Text(category.name!),
                      selected: selectedCategory == category.name,
                      onSelected: (bool selected) {
                        handleCategorySelected(category.name!, ref);
                      },
                      selectedColor: context.colorTheme.blueAzure,
                      backgroundColor: Colors.transparent,
                      labelStyle: TextStyle(
                          color: selectedCategory == category.name!
                              ? Colors.white
                              : context.colorTheme.blueAzure),
                      side: BorderSide(color: context.colorTheme.blueAzure),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              ResearchGroupConfig.buttonBorderRadius)),
                    )),
              )
              .toList(),
        ),
      ),
    );
  }
}

class _ResearchGroupListBody extends ConsumerWidget {
  final String? selectedTag;
  const _ResearchGroupListBody({this.selectedTag});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(scientificCircleListProvider);
    return Expanded(
        child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: ResearchGroupConfig.mediumPadding),
            child: switch (state) {
              AsyncLoading() => const ResearchGroupLoading(),
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
      padding: const EdgeInsets.only(bottom: ResearchGroupConfig.mediumPadding),
      gridDelegate: ResearchGroupConfig.researchGroupTabGridDelegate,
      itemCount: filteredCircles.length,
      itemBuilder: (context, index) =>
          ResearchGroupCard(filteredCircles[index]),
    );
  }
}
