import "dart:async";

import "package:anim_search_bar/anim_search_bar.dart";
import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "../../../../config/ui_config.dart";
import "../../../../theme/app_theme.dart";
import "../../../../utils/context_extensions.dart";
import "../../../analytics/data/clarity.dart";
import "../../../analytics/data/clarity_events.dart";
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
      right: isExpanded.value ? FilterConfig.searchFilterPadding : context.textScaler.scale(20),
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
            onChanged: (res) {
              ref.read(searchFiltersControllerProvider.notifier).onTextChanged(res);
            }, // I had to fork the lib and add this callback myself 😭
            textFieldColor: context.colorScheme.surfaceTint,
            textFieldIconColor: context.colorScheme.onTertiary,
            color: context.colorScheme.surface,
            autoFocus: true,
            searchIconColor: context.colorScheme.onTertiary,
            helpText: context.localize.search,
            boxShadow: false,
            searchBarOpen: (int x) {
              isExpanded.value = x == 1; // this lib is stupid as f...
              textController.text = ref.read(searchFiltersControllerProvider);
              unawaited(ref.trackEvent(ClarityEvents.searchSciClubFilters));
            },
            height: 48,
            clearOnSuffixTap: true,
            closeOnSubmit: false,
          ),
        ),
      ),
    );
  }
}
