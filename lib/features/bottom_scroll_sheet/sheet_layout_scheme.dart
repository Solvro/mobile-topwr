import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "../../../theme/app_theme.dart";
import "../../utils/context_extensions.dart";
import "../../widgets/search_box_app_bar.dart";
import "../map_view/controllers/bottom_sheet_controller.dart";
import "../map_view/controllers/controllers_set.dart";
import "../map_view/widgets/map_config.dart";
import "data_list.dart";
import "drag_handle.dart";
import "navigate_button.dart";

class SheetLayoutScheme<T extends GoogleNavigable> extends HookConsumerWidget {
  const SheetLayoutScheme({this.scrollController, super.key});

  final ScrollController? scrollController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCategory = useState<String>(context.localize.buildings_title);

    final appBar = SearchBoxAppBar(
      context,
      title: context.mapViewTexts<T>().title,
      onQueryChanged: ref.watch(context.mapDataController<T>().notifier).onSearchQueryChanged,
      onSearchBoxTap: ref.watch(bottomSheetPixelsProvider.notifier).onSearchBoxTap,
      actions: [if (ref.watch(context.activeMarkerController<T>()) != null) NavigateButton<T>()],
    );

    final categoryData = (
      buildings: (title: context.localize.buildings_title, builder: DataSliverList<T>.new),
      library: (
        title: context.localize.library_title,
        builder: () => const SliverToBoxAdapter(child: Center(child: Text("Lorem ipsum"))),
      ),
      showers: (
        title: context.localize.showers_title,
        builder: () => const SliverToBoxAdapter(child: Center(child: Text("Lorem ipsum"))),
      ),
    );

    final validSelectedCategory =
        categoryData.buildings.title == selectedCategory.value
            ? categoryData.buildings
            : categoryData.library.title == selectedCategory.value
            ? categoryData.library
            : categoryData.showers;

    return CustomScrollView(
      controller: scrollController,
      slivers: [
        const SliverPersistentHeader(pinned: true, delegate: DragHandle()),
        SliverAppBar(
          primary: false,
          pinned: true,
          toolbarHeight: appBar.preferredSize.height,
          flexibleSpace: appBar,
          automaticallyImplyLeading: false,
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: SearchBoxAppBar.defaultBottomPadding),
            child: CupertinoSlidingSegmentedControl<String>(
              backgroundColor: context.colorTheme.greyLight,
              thumbColor: context.colorTheme.orangePomegranadeLighter,
              groupValue: selectedCategory.value,
              onValueChanged: (value) {
                if (value != null) {
                  selectedCategory.value = value;
                }
              },
              children: {
                categoryData.buildings.title: _SegmentTab(
                  title: categoryData.buildings.title,
                  isSelected: selectedCategory.value == categoryData.buildings.title,
                ),
                categoryData.library.title: _SegmentTab(
                  title: categoryData.library.title,
                  isSelected: selectedCategory.value == categoryData.library.title,
                ),
                categoryData.showers.title: _SegmentTab(
                  title: categoryData.showers.title,
                  isSelected: selectedCategory.value == categoryData.showers.title,
                ),
              },
            ),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: SearchBoxAppBar.defaultBottomPadding)),
        validSelectedCategory.builder(),
      ],
    );
  }
}

class _SegmentTab extends StatelessWidget {
  const _SegmentTab({required this.title, required this.isSelected});

  final String title;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        color: isSelected ? context.colorTheme.whiteSoap : context.colorTheme.blackMirage,
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
      ),
    );
  }
}
