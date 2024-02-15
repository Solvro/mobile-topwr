import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../theme/app_theme.dart';
import '../utils/context_extensions.dart';

class SearchWidget extends ConsumerWidget {
  final void Function(String query) onQueryChanged;
  const SearchWidget({super.key, required this.onQueryChanged});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: TextField(
        onChanged: onQueryChanged,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.zero,
          filled: true,
          fillColor: context.colorTheme.greyLight,
          hintText: '${context.localize!.search}...',
          hintStyle: TextStyle(
            color: context.colorTheme.greyPigeon,
            fontWeight: FontWeight.w400,
            fontSize: 15,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(8),
            gapPadding: 0,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(8),
            gapPadding: 0,
          ),
          prefixIcon: Icon(
            Icons.search_outlined,
            size: 14,
            color: context.colorTheme.greyPigeon,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
