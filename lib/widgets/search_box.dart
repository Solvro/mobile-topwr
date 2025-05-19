import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:flutter_svg/svg.dart";

import "../config/ui_config.dart";
import "../gen/assets.gen.dart";
import "../theme/app_theme.dart";
import "../utils/context_extensions.dart";

class SearchBox extends HookWidget {
  const SearchBox({super.key, required this.onQueryChanged, this.onTap, this.searchText});
  final VoidCallback? onTap;
  final String? searchText;
  final void Function(String query) onQueryChanged;

  @override
  Widget build(BuildContext context) {
    final focusNode = useFocusNode();
    final controller = useTextEditingController();
    final showCloseIcon = useState(false);

    final onTapOutside = useCallback((_) {
      if (focusNode.hasFocus) {
        focusNode.unfocus();
      }
    }, [focusNode]);

    final onChanged = useCallback((String query) {
      showCloseIcon.value = query != "";
      onQueryChanged(query);
    }, [showCloseIcon, onQueryChanged]);

    final onSuffixPressed = useCallback(() {
      context.unfocus();
      controller.clear();
      onChanged("");
    }, [controller, onChanged, context]);

    final color = context.colorTheme.blackMirage.withValues(alpha: 0.48);

    return TextField(
      controller: controller,
      focusNode: focusNode,
      onTap: onTap,
      onTapOutside: onTapOutside,
      onChanged: onChanged,
      decoration: InputDecoration(
        constraints: BoxConstraints(maxHeight: context.textScaler.scale(SearchBoxConfig.height)),
        contentPadding: context.isTextScaledUp ? const EdgeInsets.symmetric(vertical: 4) : EdgeInsets.zero,
        filled: true,
        fillColor: context.colorTheme.greyLight,
        hintText: "${searchText ?? context.localize.search}...",
        hintStyle: context.textTheme.lightTitle.copyWith(color: color),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
        prefixIcon: ExcludeSemantics(
          child: Padding(padding: const EdgeInsets.all(10), child: SvgPicture.asset(Assets.svg.searchBox.vectorsearch)),
        ),
        suffixIcon:
            showCloseIcon.value
                ? IconButton(
                  tooltip: context.localize.clear_search,
                  icon: Icon(Icons.cancel, color: context.colorTheme.blackMirage, size: context.textScaler.scale(19)),
                  onPressed: onSuffixPressed,
                )
                : null,
      ),
    );
  }
}
