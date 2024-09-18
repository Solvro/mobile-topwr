import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:flutter_svg/svg.dart";

import "../config/ui_config.dart";
import "../gen/assets.gen.dart";
import "../theme/app_theme.dart";
import "../utils/context_extensions.dart";

class SearchBox extends ConsumerStatefulWidget {
  final void Function(String query) onQueryChanged;
  final VoidCallback? onTap;
  final String? searchText;

  const SearchBox({
    super.key,
    required this.onQueryChanged,
    this.onTap,
    this.searchText,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SearchBoxState();
}

class _SearchBoxState extends ConsumerState<SearchBox> {
  final controller = TextEditingController();
  final focusNode = FocusNode();
  bool showCloseIcon = false;

  void _onChanged(String query) {
    setState(() {
      showCloseIcon = query != "";
    });
    widget.onQueryChanged(query);
  }

  void _clearButtonAction() {
    context.unfocus();
    controller.clear();
    _onChanged("");
  }

  void _onTapOutside(_) {
    if (focusNode.hasFocus) {
      focusNode.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = context.colorTheme.blackMirage.withOpacity(0.48);
    return TextField(
      controller: controller,
      focusNode: focusNode,
      onChanged: _onChanged,
      onTap: widget.onTap,
      onTapOutside: _onTapOutside,
      decoration: InputDecoration(
        constraints: const BoxConstraints(maxHeight: SearchBoxConfig.height),
        contentPadding: EdgeInsets.zero,
        filled: true,
        fillColor: context.colorTheme.greyLight,
        hintText: "${widget.searchText ?? context.localize.search}...",
        hintStyle: context.textTheme.lightTitle.copyWith(color: color),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        prefixIcon: Padding(
          padding: const EdgeInsets.all(10),
          child: SvgPicture.asset(Assets.svg.searchBox.vectorsearch),
        ),
        suffixIcon: showCloseIcon
            ? IconButton(
                icon: Icon(
                  Icons.cancel,
                  color: context.colorTheme.blackMirage,
                  size: 19,
                ),
                onPressed: _clearButtonAction,
              )
            : null,
      ),
    );
  }
}
