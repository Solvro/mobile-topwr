import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../theme/app_theme.dart';
import '../../../utils/context_extensions.dart';
import '../repositories/search_provider.dart';

class SearchWidget extends ConsumerStatefulWidget {
  const SearchWidget({super.key});

  @override
  ConsumerState<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends ConsumerState<SearchWidget> {
  @override
  Widget build(BuildContext context) {
    final searchController = ref.read(searchControllerProvider);
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: TextField(
        controller: searchController,
        onChanged: (query) {},
        decoration: InputDecoration(
          contentPadding: EdgeInsets.zero,
          hintText: '${context.localize!.search}...',
          hintStyle: TextStyle(
            color: context.colorTheme.blackMirage,
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
          icon: Icon(
            Icons.search_outlined,
            size: 14,
            color: context.colorTheme.blackMirage,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
