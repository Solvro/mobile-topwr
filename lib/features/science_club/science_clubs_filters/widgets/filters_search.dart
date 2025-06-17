import "dart:async";

import "package:anim_search_bar/anim_search_bar.dart";
import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "../../../../config/ui_config.dart";
import "../../../../theme/app_theme.dart";
import "../../../../utils/context_extensions.dart";
import "../../../analytics/data/umami.dart";
import "../../../analytics/data/umami_events.dart";
import "../filters_search_controller.dart";

class FiltersSearch extends HookConsumerWidget {
  const FiltersSearch({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isExpanded = useState(false);
    final textController = useTextEditingController();

    final expandedWidth =
        MediaQuery.sizeOf(context).width -
        2 * FilterConfig.searchFilterPadding -
        MediaQuery.viewInsetsOf(context).horizontal;

    // loads of fixed values, but the search box library is a very fixed
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 300),
      left: isExpanded.value ? FilterConfig.searchFilterPadding : context.textScaler.scale(67),
      top: 16,
      child: Semantics(
        label: context.localize.search,
        button: true,
        container: true,
        child: ExcludeSemantics(
          child: AnimSearchBar(
            width: expandedWidth,
            textController: textController,
            onSuffixTap: () {},
            onChanged:
                ref
                    .watch(searchFiltersControllerProvider.notifier)
                    .onTextChanged, // I had to fork the lib and add this callback myself 😭
            textFieldColor: context.colorTheme.greyLight,
            textFieldIconColor: context.colorTheme.blackMirage,
            color: context.colorTheme.whiteSoap,
            autoFocus: true,
            searchIconColor: context.colorTheme.blackMirage,
            helpText: context.localize.search,
            boxShadow: false,
            searchBarOpen: (int x) {
              isExpanded.value = x == 1; // this lib is stupid as f...
              if (!isExpanded.value) {
                ref.read(searchFiltersControllerProvider.notifier).onTextChanged("");
              }
              unawaited(ref.trackEvent(UmamiEvents.searchSciClubFilters));
            },
            height: 48,
            clearOnClose: true,
            clearOnSuffixTap: true,
            closeOnSubmit: false,
          ),
        ),
      ),
    );
  }
}
