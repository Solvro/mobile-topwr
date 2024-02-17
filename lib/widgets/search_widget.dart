import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

import '../config.dart';
import '../theme/app_theme.dart';
import '../utils/context_extensions.dart';

class SearchWidget extends ConsumerStatefulWidget {
  final void Function(String query) onQueryChanged;
  final VoidCallback? onTap;
  const SearchWidget({
    super.key,
    required this.onQueryChanged,
    this.onTap,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends ConsumerState<SearchWidget> {
  final controller = TextEditingController();
  final focusNode = FocusNode();
  var showCloseIcon = false;

  void onChanged(String query) {
    setState(() {
      showCloseIcon = query != "";
    });
    widget.onQueryChanged(query);
  }

  @override
  Widget build(BuildContext context) {
    final color = context.colorTheme.blackMirage.withOpacity(0.48);
    return TextField(
      controller: controller,
      focusNode: focusNode,
      onChanged: onChanged,
      onTap: widget.onTap,
      onTapOutside: (_) {
        if (focusNode.hasFocus) {
          focusNode.unfocus();
        }
      },
      decoration: InputDecoration(
        constraints: const BoxConstraints(maxHeight: SearchWidgetConfig.height),
        contentPadding: EdgeInsets.zero,
        filled: true,
        fillColor: context.colorTheme.greyLight,
        hintText: '${context.localize!.search}...',
        hintStyle: context.textTheme.lightTitle.copyWith(color: color),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide.none,
        ),
        prefixIcon: Padding(
          padding: const EdgeInsets.all(10),
          child: SvgPicture.asset(SearchWidgetConfig.searchIconName),
        ),
        suffixIcon: showCloseIcon
            ? IconButton(
                icon: Icon(
                  Icons.cancel,
                  color: context.colorTheme.blackMirage,
                  size: 19,
                ),
                onPressed: () {
                  controller.clear();
                  onChanged("");
                },
              )
            : null,
      ),
    );
  }
}
